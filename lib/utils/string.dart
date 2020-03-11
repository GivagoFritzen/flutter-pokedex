class StringUtil {
  static String UppercaseFirstLetterOfEachWord(String text) {
    String newText = RemoveSpecialCharacters(text);

    var splitStr = newText.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
      splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
    }

    return splitStr.join(' ');
  }

  static String RemoveSpecialCharacters(String text) {
    return text.replaceAll(new RegExp(r'[^\w\s]+'), ' ');
  }
}
