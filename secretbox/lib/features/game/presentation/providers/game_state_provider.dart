// lib/domain/game_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/features/game/domain/providers/game_providers.dart';
import 'package:secretbox/features/game/domain/repositories/game_repository.dart';
import 'package:secretbox/features/game/presentation/providers/state/game_notifier.dart';
import 'package:secretbox/features/game/presentation/providers/state/game_state.dart';

final gameStateNotifierProvider =
    StateNotifierProvider<GameNotifier, GameState>((ref) {
      final GameRepository gameRepository = ref.watch(gameRepositoryProvider);
      return GameNotifier(gameRepository: gameRepository);
    });

final voucherCodeProvider = StateProvider<String>((ref) => '');