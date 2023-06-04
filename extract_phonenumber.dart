class TextService{

  RegExp phoneRegExp = RegExp(
      r'(?:(?:\+|0{0,2})[1-9]\d{0,2})?[ -]?\(?(?:\d{1,3})\)?[ -]?\d{1,4}[ -]?\d{1,4}[ -]?\d{1,9}\b');
  List<TextSpan> extractPhoneNumberText(String rawString, Color textColor) {
    List<TextSpan> textSpan = [];

    String getPhoneNumber(String phoneString) {
      textSpan.add(
        TextSpan(
          text: phoneString,
          style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: SizeConfig.textMultiplier * 2),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _makePhoneCall('tel:$phoneString');
            },
        ),
      );
      return phoneString;
    }

    getNormalText(String normalText) {
      textSpan.add(
        TextSpan(
          text: normalText,
          style: new TextStyle(
              color: textColor, fontSize: SizeConfig.textMultiplier * 2),
        ),
      );
      return normalText;
    }

    rawString.splitMapJoin(
      phoneRegExp,
      onMatch: (m) => getPhoneNumber("${m.group(0)}"),
      onNonMatch: (n) => getNormalText("${n.substring(0)}"),
    );

    return textSpan;
  }}
