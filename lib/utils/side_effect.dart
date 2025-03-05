import 'dart:async';

class SideEffect<TObservee> {
  SideEffect({
    required Stream<TObservee> observee,
    required bool Function(TObservee? previousValue, TObservee currentValue) doWhen,
    required void Function(TObservee value) sideEffect,
  }) {
    _streamSubscription = observee.listen(
      (value) {
        if (doWhen(_previousValue, value) == true) {
          sideEffect(value);
        }

        _previousValue = value;
      }
    );
  }

  void dispose() {
    _streamSubscription.cancel();
  }




  TObservee? _previousValue;
  late final StreamSubscription<TObservee> _streamSubscription;
}
