

class MyLocale {
  String title;
  String subTitle;
  String languageCode;
  String countryCode;
  MyLocale({required this.title, required this.subTitle, required this.languageCode, required this.countryCode});

  factory MyLocale.fromJson(Map<String, dynamic> data) {
    final String title = data['title'] as String;
    final String subTitle = data['subTitle'] as String;
    final String languageCode = data['languageCode'] as String;
    final String countryCode = data['countryCode'] as String;
    return MyLocale(title: title, subTitle: subTitle, languageCode: languageCode, countryCode: countryCode);
  }
}
