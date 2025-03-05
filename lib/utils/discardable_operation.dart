import 'dart:async';

class DiscardableOperation<TResult> {
  DiscardableOperation({
    required Future<TResult> Function() operation,
    required void Function(TResult result) onComplete,
    void Function(Error error)? onError
  }) :
    _operation = operation,
    _onComplete = onComplete,
    _onError = onError;

  Future<TResult> perform() {
    final completer = Completer<TResult>();

    _operation()
      .then(
        (futureResult) {
          if (_isDiscarded) {
            return;
          }

          completer.complete(futureResult);
          _onComplete(futureResult);
        },
        onError: (error) {
          if (_isDiscarded) {
            return;
          }

          completer.completeError(error);
          _onError?.call(error);
        },
      );

    return completer.future;
  }

  void discard() {
    _isDiscarded = true;
  }


  final Future<TResult> Function() _operation;
  final void Function(TResult result) _onComplete;
  final void Function(Error error)? _onError;
  bool _isDiscarded = false;
}