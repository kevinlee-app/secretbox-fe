import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secretbox/shared/domain/models/box_state.dart';
import 'package:secretbox/shared/domain/models/gameplay_state.dart';
import 'package:secretbox/shared/domain/models/setting.dart';
import 'package:secretbox/shared/domain/models/voucher.dart';
import 'package:secretbox/shared/exceptions/http_exception.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState.initial() = Initial;
  const factory GameState.loading({Setting? setting}) = Loading;
  const factory GameState.failure(AppException exception) = Failure;
  const factory GameState.success({
    required List<bool> revealed,
    required List<BoxState> boxStates,
    required GameplayState gameplayState,
    required String countdownText,
    required Setting setting,
    Voucher? voucher,
    String? error,
  }) = Success;
}
