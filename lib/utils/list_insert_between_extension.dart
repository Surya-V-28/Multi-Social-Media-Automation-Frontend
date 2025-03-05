extension InsertBetweenExtension<TValue> on Iterable<TValue> {
  List<TValue> insertBetween(TValue toInsert) {
    final List<TValue> r = List<TValue>.empty(growable: true);

    int i = 0;
    for (final TValue value in this) {
      if (i != 0) r.add(toInsert);
      
      r.add(value);

      ++i;
    }

    return r;
  }
}
