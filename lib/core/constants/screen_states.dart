class ScreenStates {
  static const int loadingState = 0;
  static const int successState = 1;
  static const int errorState = 2;
  static const int emptyState = 3;
  static const int noConnection = 4;

  int currentState;

  ScreenStates({this.currentState = loadingState});
}
