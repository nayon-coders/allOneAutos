class AppConfig{

  //app name
  static const String AppName = "Car Rent";


  //api connection
  static const String domain = "http://ecom.hungeat.com";
  static const String Baseurl = "http://ecom.hungeat.com/api";



  //API lists
  static const String registration = "$Baseurl/register";
  static const String login = "$Baseurl/login";
  static const String verification = "$Baseurl/token/save";
  static const String checkVerification = "$Baseurl/token/check";
  static const String reendVerification = "$Baseurl/token/resend";
  static const String createCarRentVendor = "$Baseurl/profile/vendor/create/car-rent";
  static const String showAllCarRentService = "$Baseurl/car-rent/show-all";
  static const String singleCarRent = "$Baseurl/car-rent/find"; //after find, set here car rent id//
  static const String sendCarRentRequest = "$Baseurl/car-rent/send-request";
  static const String carRentRequestList = "$Baseurl/vendor/rent-request";
  static const String pendingRentList = "$Baseurl/vendor/rent-request/pending";
  static const String acceptRentList = "$Baseurl/vendor/rent-request/accept";
  static const String cancelRentList = "$Baseurl/vendor/rent-request/cancel";
  static const String vendorRequestUpdate = "$Baseurl/vendor/rent-request";


}