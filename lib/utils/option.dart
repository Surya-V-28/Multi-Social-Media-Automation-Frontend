class Option<TValue> {
  const Option(this.value);

  static TValue resolveWithFallback<TValue>(Option<TValue>? option, TValue fallbackValue) {
    if (option != null) {
      return option.value;
    }
    else {
      return fallbackValue;
    }
  }


  final TValue value;
}
