import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/features/game/domain/repositories/game_repository.dart';
import 'package:secretbox/features/game/presentation/providers/state/game_state.dart';
import 'package:secretbox/shared/domain/models/box_state.dart';
import 'package:secretbox/shared/domain/models/gameplay_state.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

class GameNotifier extends StateNotifier<GameState> {
  final GameRepository gameRepository;

  GameNotifier({required this.gameRepository})
    : super(const GameState.initial());

  Future<void> initializeGame() async {
    state = const GameState.initial();

    final response = await gameRepository.getLocalSetting();

    await response.fold(
      (error) async => await getSetting(),
      (setting) async => await getSetting(setting: setting),
    );
  }

  Future<void> getSetting({Setting? setting}) async {
    state = GameState.loading(setting: setting);

    final response = await gameRepository.getSetting();

    state = await response.fold((failure) => GameState.failure(failure), (
      setting,
    ) async {
      final hasSetting = await gameRepository.saveSetting(setting: setting);
      if (hasSetting) {
        return _resetState(setting);
      }

      return GameState.failure(CacheFailureException());
    });
  }

  GameState _resetState(Setting setting) {
    return GameState.success(
      revealed: List.generate(setting.prizes.length, (_) => false),
      boxStates: List.generate(setting.prizes.length, (_) => BoxState.closed),
      gameplayState: GameplayState.waiting,
      countdownText: '',
      setting: setting,
    );
  }

  void startGame(Voucher newVoucher) {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) {
        setting.prizes.shuffle(Random());

        for (int i = 0; i < setting.prizes.length; i++) {
          _startSpinTimer(i);
        }

        return GameState.success(
          revealed: List.generate(10, (_) => false),
          boxStates: List.generate(10, (_) => BoxState.closed),
          gameplayState: GameplayState.started,
          countdownText: '',
          setting: setting,
          voucher: newVoucher,
        );
      },
      orElse: () => state,
    );
  }

  void _startSpinTimer(int index) {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) {
        final newBoxStates = List<BoxState>.from(boxStates)
          ..[index] = BoxState.spinning;

        return GameState.success(
          revealed: revealed,
          boxStates: newBoxStates,
          gameplayState: gameplayState,
          countdownText: countdownText,
          setting: setting,
          voucher: voucher,
        );
      },
      orElse: () => state,
    );

    int secondsRemaining = 4;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 1) {
        secondsRemaining--;
        final newBoxStates = List.generate(10, (_) => BoxState.spinning)
          ..[index] = BoxState.spinning;

        state = state.maybeWhen(
          success: (
            revealed,
            boxStates,
            gameplayState,
            countdownText,
            setting,
            voucher,
            error,
          ) {
            return GameState.success(
              revealed: revealed,
              boxStates: newBoxStates,
              gameplayState: gameplayState,
              countdownText:
                  '${setting.wording.spinningText} $secondsRemaining',
              setting: setting,
              voucher: voucher,
            );
          },
          orElse: () => state,
        );
      } else {
        timer.cancel();

        state = state.maybeWhen(
          success: (
            revealed,
            boxStates,
            gameplayState,
            countdownText,
            setting,
            voucher,
            error,
          ) {
            final updatedBoxStates = List<BoxState>.from(boxStates)
              ..[index] = BoxState.closed;

            return GameState.success(
              revealed: revealed,
              boxStates: updatedBoxStates,
              gameplayState: GameplayState.choosing,
              countdownText: setting.wording.choosePrizeText,
              setting: setting,
              voucher: voucher,
            );
          },
          orElse: () => state,
        );
      }
    });
  }

  Future<void> revealPrize(int index) async {
    state = await state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) async {
        final response = await gameRepository.openPrize(voucher?.code ?? '');
        if (response.isRight()) {
          final updatedRevealed = List<bool>.filled(revealed.length, true);
          final winIndex =
              voucher?.prizeId != null
                  ? setting.prizes.indexWhere(
                    (prize) => prize.id == voucher?.prizeId,
                  )
                  : index;
          if (winIndex != index) {
            final winPrize = setting.prizes[winIndex];
            final swappedPrize = setting.prizes[index];
            setting.prizes[index] = winPrize;
            setting.prizes[winIndex] = swappedPrize;
          }

          return GameState.success(
            revealed: updatedRevealed,
            boxStates: boxStates,
            gameplayState: GameplayState.finished,
            countdownText: setting.wording.winningFullText(
              setting.prizes[index].name,
              voucher?.username ?? '',
            ),
            setting: setting,
            voucher: voucher,
          );
        } else {
          return GameState.initial();
        }
      },
      orElse: () => state,
    );
  }

  void showAllPrizes() {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) {
        return GameState.success(
          revealed: revealed,
          boxStates: boxStates,
          gameplayState: GameplayState.showing,
          countdownText: countdownText,
          setting: setting,
          voucher: voucher,
        );
      },
      orElse: () => state,
    );
  }

  void showVoucherInput(bool shouldReset) {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
        error,
      ) {
        if(shouldReset) {
          setting.prizes.shuffle(Random());
        }
        return _resetState(setting);
      },
      orElse: () => state,
    );
  }

  Future<void> getVoucher(String code) async {
    final current = state;
    if (current is Success) {
      state = current.copyWith(gameplayState: GameplayState.verifying);

      final response = await gameRepository.getVoucher(code);

      response.fold(
        (error) {
          state = current.copyWith(
            gameplayState: GameplayState.waiting,
            error: error.message,
          );
        },
        (voucher) {
          startGame(voucher);
          print("NEW VOUCHER: ${voucher.prizeId}");
        },
      );
    }
  }
}
