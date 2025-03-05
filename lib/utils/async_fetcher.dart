import 'dart:async';

import 'package:rxdart/rxdart.dart';

class AsyncFetcher<TReturnValue> {
  AsyncFetcher(this._fetchFunction,);

  Future<TReturnValue> fetch() {
    final completer = Completer<TReturnValue>();

    _operationIndex++;
    final operationIndex = _operationIndex;

    _state = AsyncFetcherState.isLoading;
    _fetchFunction()
      .then(
        (value) {
          if (operationIndex != _operationIndex) {
            return;
          }

          latestValue.add(value);
          _state = AsyncFetcherState.idle;

          completer.complete(value);
        },
        onError: (futureError) {
          if (operationIndex != _operationIndex) {
            return;
          }

          latestError.add(futureError);
          _state = AsyncFetcherState.idle;

          completer.completeError(futureError);
        }
      );

    return completer.future;
  }

  AsyncFetcherState get state => _state;


  var _operationIndex = -1;
  var _state = AsyncFetcherState.idle;

  final Future<TReturnValue> Function() _fetchFunction;
  final latestError = BehaviorSubject<Error?>.seeded(null);
  final latestValue = BehaviorSubject<TReturnValue?>.seeded(null);
}

enum AsyncFetcherState {
  idle,
  isLoading,
}