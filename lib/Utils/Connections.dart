// ignore_for_file: file_names, camel_case_types

class con {
  static const String _host = "http://167.235.74.243:5000";

  static const String loginapi = "$_host/login";
  static const String registerapi = "$_host/register";
  static const String uploadDocument = "$_host/uploadDocument";
  static const String uploadDocumentDetails = "$_host/updatedocuments";
//home
  static const String productcountapi = "$_host/api/dailystock";
//get bar sales
  static const String getweeksales = "$_host/api/getweekbar";
  static const String getdaysales = "$_host/api/getdaybar";
  static const String getmonthsales = "$_host/api/getmonthbar";
  static const String getyearsales = "$_host/api//getyearbar";

  static const String getproduct = "$_host/product/getproduct";
  static const String sellproduct = "$_host/product/sellproduct";
}
