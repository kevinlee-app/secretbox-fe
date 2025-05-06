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
          ) {
            return GameState.success(
              revealed: revealed,
              boxStates: newBoxStates,
              gameplayState: gameplayState,
              countdownText:
                  '${setting.wording.spinningText} $secondsRemaining',
              setting: setting,
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

  void revealPrize(int index) {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
      ) {
        final updatedRevealed = List<bool>.from(revealed)..[index] = true;

        return GameState.success(
          revealed: updatedRevealed,
          boxStates: boxStates,
          gameplayState: GameplayState.finished,
          countdownText: setting.wording.winningFullText(
            setting.prizes[index].name,
          ),
          setting: setting,
          voucher: voucher,
        );
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

  void showVoucherInput() {
    state = state.maybeWhen(
      success: (
        revealed,
        boxStates,
        gameplayState,
        countdownText,
        setting,
        voucher,
      ) {
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
          state = current.copyWith(gameplayState: GameplayState.waiting);
        },
        (voucher) {
          startGame(voucher);
        },
      );
    }
  }
}
