enum GameplayState { waiting, showing, started, verifying, choosing, finished }

extension GameplayStateX on GameplayState {
  bool get canStart =>
      this == GameplayState.waiting ||
      this == GameplayState.finished ||
      this == GameplayState.showing;

  bool get canShowPrize => this == GameplayState.waiting;

  bool get canShowPlayView =>
      this == GameplayState.showing || this == GameplayState.finished;
}
