extension StringUtils on String {
  String toSentenceCase() {
    if (isEmpty) return "";

    var result = substring(0, 1).toUpperCase();

    if (length > 1) {
      result += substring(1);
    }

    return result;
  }
}
