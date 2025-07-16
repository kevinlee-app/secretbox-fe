// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Setting? setting) loading,
    required TResult Function(AppException exception) failure,
    required TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Setting? setting)? loading,
    TResult? Function(AppException exception)? failure,
    TResult? Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Setting? setting)? loading,
    TResult Function(AppException exception)? failure,
    TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Failure value) failure,
    required TResult Function(Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Failure value)? failure,
    TResult? Function(Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Failure value)? failure,
    TResult Function(Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GameState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Setting? setting) loading,
    required TResult Function(AppException exception) failure,
    required TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)
        success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Setting? setting)? loading,
    TResult? Function(AppException exception)? failure,
    TResult? Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Setting? setting)? loading,
    TResult Function(AppException exception)? failure,
    TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Failure value) failure,
    required TResult Function(Success value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Failure value)? failure,
    TResult? Function(Success value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Failure value)? failure,
    TResult Function(Success value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements GameState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Setting? setting});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setting = freezed,
  }) {
    return _then(_$LoadingImpl(
      setting: freezed == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl({this.setting});

  @override
  final Setting? setting;

  @override
  String toString() {
    return 'GameState.loading(setting: $setting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.setting, setting) || other.setting == setting));
  }

  @override
  int get hashCode => Object.hash(runtimeType, setting);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Setting? setting) loading,
    required TResult Function(AppException exception) failure,
    required TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)
        success,
  }) {
    return loading(setting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Setting? setting)? loading,
    TResult? Function(AppException exception)? failure,
    TResult? Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
  }) {
    return loading?.call(setting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Setting? setting)? loading,
    TResult Function(AppException exception)? failure,
    TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(setting);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Failure value) failure,
    required TResult Function(Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Failure value)? failure,
    TResult? Function(Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Failure value)? failure,
    TResult Function(Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements GameState {
  const factory Loading({final Setting? setting}) = _$LoadingImpl;

  Setting? get setting;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$FailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements Failure {
  const _$FailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'GameState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Setting? setting) loading,
    required TResult Function(AppException exception) failure,
    required TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)
        success,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Setting? setting)? loading,
    TResult? Function(AppException exception)? failure,
    TResult? Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Setting? setting)? loading,
    TResult Function(AppException exception)? failure,
    TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Failure value) failure,
    required TResult Function(Success value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Failure value)? failure,
    TResult? Function(Success value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Failure value)? failure,
    TResult Function(Success value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure implements GameState {
  const factory Failure(final AppException exception) = _$FailureImpl;

  AppException get exception;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<bool> revealed,
      List<BoxState> boxStates,
      GameplayState gameplayState,
      String countdownText,
      Setting setting,
      Voucher? voucher,
      String? error});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revealed = null,
    Object? boxStates = null,
    Object? gameplayState = null,
    Object? countdownText = null,
    Object? setting = null,
    Object? voucher = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SuccessImpl(
      revealed: null == revealed
          ? _value._revealed
          : revealed // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      boxStates: null == boxStates
          ? _value._boxStates
          : boxStates // ignore: cast_nullable_to_non_nullable
              as List<BoxState>,
      gameplayState: null == gameplayState
          ? _value.gameplayState
          : gameplayState // ignore: cast_nullable_to_non_nullable
              as GameplayState,
      countdownText: null == countdownText
          ? _value.countdownText
          : countdownText // ignore: cast_nullable_to_non_nullable
              as String,
      setting: null == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting,
      voucher: freezed == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as Voucher?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements Success {
  const _$SuccessImpl(
      {required final List<bool> revealed,
      required final List<BoxState> boxStates,
      required this.gameplayState,
      required this.countdownText,
      required this.setting,
      this.voucher,
      this.error})
      : _revealed = revealed,
        _boxStates = boxStates;

  final List<bool> _revealed;
  @override
  List<bool> get revealed {
    if (_revealed is EqualUnmodifiableListView) return _revealed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_revealed);
  }

  final List<BoxState> _boxStates;
  @override
  List<BoxState> get boxStates {
    if (_boxStates is EqualUnmodifiableListView) return _boxStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boxStates);
  }

  @override
  final GameplayState gameplayState;
  @override
  final String countdownText;
  @override
  final Setting setting;
  @override
  final Voucher? voucher;
  @override
  final String? error;

  @override
  String toString() {
    return 'GameState.success(revealed: $revealed, boxStates: $boxStates, gameplayState: $gameplayState, countdownText: $countdownText, setting: $setting, voucher: $voucher, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            const DeepCollectionEquality().equals(other._revealed, _revealed) &&
            const DeepCollectionEquality()
                .equals(other._boxStates, _boxStates) &&
            (identical(other.gameplayState, gameplayState) ||
                other.gameplayState == gameplayState) &&
            (identical(other.countdownText, countdownText) ||
                other.countdownText == countdownText) &&
            (identical(other.setting, setting) || other.setting == setting) &&
            (identical(other.voucher, voucher) || other.voucher == voucher) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_revealed),
      const DeepCollectionEquality().hash(_boxStates),
      gameplayState,
      countdownText,
      setting,
      voucher,
      error);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Setting? setting) loading,
    required TResult Function(AppException exception) failure,
    required TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)
        success,
  }) {
    return success(revealed, boxStates, gameplayState, countdownText, setting,
        voucher, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Setting? setting)? loading,
    TResult? Function(AppException exception)? failure,
    TResult? Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
  }) {
    return success?.call(revealed, boxStates, gameplayState, countdownText,
        setting, voucher, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Setting? setting)? loading,
    TResult Function(AppException exception)? failure,
    TResult Function(
            List<bool> revealed,
            List<BoxState> boxStates,
            GameplayState gameplayState,
            String countdownText,
            Setting setting,
            Voucher? voucher,
            String? error)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(revealed, boxStates, gameplayState, countdownText, setting,
          voucher, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Failure value) failure,
    required TResult Function(Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Failure value)? failure,
    TResult? Function(Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Failure value)? failure,
    TResult Function(Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success implements GameState {
  const factory Success(
      {required final List<bool> revealed,
      required final List<BoxState> boxStates,
      required final GameplayState gameplayState,
      required final String countdownText,
      required final Setting setting,
      final Voucher? voucher,
      final String? error}) = _$SuccessImpl;

  List<bool> get revealed;
  List<BoxState> get boxStates;
  GameplayState get gameplayState;
  String get countdownText;
  Setting get setting;
  Voucher? get voucher;
  String? get error;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
