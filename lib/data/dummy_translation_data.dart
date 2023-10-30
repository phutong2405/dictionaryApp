Iterable<LanguagesItem> languageIterable = [
  const LanguagesItem(title: 'English', status: true, icon: '🇺🇸', id: '1'),
  const LanguagesItem(
      title: 'Vietnamese', status: false, icon: '🇻🇳', id: '2'),
  const LanguagesItem(title: 'German', status: true, icon: '🇩🇪', id: '3')
];

class LanguagesItem {
  final String id;
  final String title;
  final bool status;
  final String icon;
  const LanguagesItem(
      {required this.title,
      required this.status,
      required this.icon,
      required this.id});
}
