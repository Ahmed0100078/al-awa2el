/// take this as input:
///
/// 'YYYY-MM-DD HH:MM:SS'
///
/// throws this output:
///
/// 'DD/MM/YY HH:MM'
String dateFormatter(String? date) {
  if (date == null) return '';
  String year = date.substring(2, 4);
  String month = date.substring(5, 7);
  String day = date.substring(8, 10);
  String hour = date.substring(11, 13);
  String min = date.substring(14, 16);

  return '$day/$month/$year $hour:$min';
//   String hh=date.substring()
}
