import 'app_config.dart';

class AppRoutes {
  static String get _baseUrl => AppConfig.baseUrl;

  // === Nearby Hospitals ===
  static String nearbyHospitalsUrl(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude&radius=3500&type=hospital&key=${AppConfig.mapApi}';
  }

  // === Auth APIs ===
  static String get userRegister => "$_baseUrl/user/register";
  static String get userLogin => "$_baseUrl/user/login";
  static String userVerify() => "$_baseUrl/user/verify";
  static String get userResendOTP => "$_baseUrl/user/resndOTP";
  static String get userForgotPassword => "$_baseUrl/user/forgot-password";
  static String get userResetPassword => "$_baseUrl/user/reset-password";

  static String get hospitalRegister => "$_baseUrl/hospital/register";
  static String get hospitalRegister2 => "$_baseUrl/hospital/locate-detail";
  static String get hospitalLogin => "$_baseUrl/hospital/login";
  static String hospitalVerify() => "$_baseUrl/hospital/verify";
  static String get hospitalResendOTP => "$_baseUrl/hospital/resendOTP";
  static String get hospitalForgotPassword =>
      "$_baseUrl/hospital/forgot-password";
  static String get hospitalResetPassword =>
      "$_baseUrl/hospital/reset-password";

  // === Profile APIs ===
  static String get userProfile => "$_baseUrl/user/profile";
  static String get hospitalProfile => "$_baseUrl/hospital/profile";

  // === Staff APIs ===
  static String get createStaff => "$_baseUrl/hospital/createStaff";
  static String get getAllStaff => "$_baseUrl/hospital/getAllStaff";
  static String getStaff(String id) => "$_baseUrl/hospital/getStaff/$id";
  static String updateStaff(String id) => "$_baseUrl/hospital/updateStaff/$id";
  static String deleteStaff(String id) => "$_baseUrl/hospital/deleteStaff/$id";

  // === Shift APIs ===
  static String createUpdateShift(String staffId) =>
      "$_baseUrl/hospital/createUpdateShift/$staffId";
  static String shiftsByStaff(String staffId) =>
      "$_baseUrl/hospital/shitBySaff/$staffId";
  static String deleteShift(String staffId) =>
      "$_baseUrl/hospital/deleteShift/$staffId";

  // === Case APIs ===
  static String createCase(String caseId) =>
      "$_baseUrl/user/create-case/$caseId";
  static String assignHospitalToCase(String caseId) =>
      "$_baseUrl/user/assign-hospital/$caseId";

  // === Upload API ===
  static String get uploadPhoto => "$_baseUrl/upload-api";

  // === AI API ===
  static String get recommendedHospitals => "$_baseUrl/ai/recommendedHospitals";
  static String get chatBot => "$_baseUrl/ai/chat";
}




//! All App Routes
/**
 class AppRoutes {
  static const String mapApi = "AIzaSyDaaNW6khrCkxJesgZCZ9lEqGqfPS6373Q";

  static const String baseUrl = "https://fyp.pelarinfruit.com/api";
  static String nearbyHospitalsUrl(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude&radius=3500&type=hospital&key=$mapApi';
  }

  // === Auth APIs ===
  static const String userRegister = "$baseUrl/user/register";
  static const String userLogin = "$baseUrl/user/login";
  static String userVerify() => '$baseUrl/user/verify';

  static const String userResendOTP = "$baseUrl/user/resndOTP";
  static const String userForgotPassword = "$baseUrl/user/forgot-password";
  static const String userResetPassword = "$baseUrl/user/reset-password";

  static const String hospitalRegister = "$baseUrl/hospital/register";
  static const String hospitalRegister2 = "$baseUrl/hospital/locate-detail";
  static const String hospitalLogin = "$baseUrl/hospital/login";
  static String hospitalVerify() => "$baseUrl/hospital/verify";
  static const String hospitalResendOTP = "$baseUrl/hospital/resendOTP";
  static const String hospitalForgotPassword =
      "$baseUrl/hospital/forgot-password";
  static const String hospitalResetPassword =
      "$baseUrl/hospital/reset-password";

  // === Profile APIs ===
  static const String userProfile = "$baseUrl/user/profile";
  static const String hospitalProfile = "$baseUrl/hospital/profile";

  // === Staff APIs ===
  static const String createStaff = "$baseUrl/hospital/createStaff";
  static const String getAllStaff = "$baseUrl/hospital/getAllStaff";
  static String getStaff(String id) => "$baseUrl/hospital/getStaff/$id";
  static String updateStaff(String id) => "$baseUrl/hospital/updateStaff/$id";
  static String deleteStaff(String id) => "$baseUrl/hospital/deleteStaff/$id";

  // === Shift APIs ===
  static String createUpdateShift(String staffId) =>
      "$baseUrl/hospital/createUpdateShift/$staffId";
  static String shiftsByStaff(String staffId) =>
      "$baseUrl/hospital/shitBySaff/$staffId";
  static String deleteShift(String staffId) =>
      "$baseUrl/hospital/deleteShift/$staffId";

  // === Case APIs ===
  static String createCase(String caseId) =>
      "$baseUrl/user/create-case/$caseId";
  static String assignHospitalToCase(String caseId) =>
      "$baseUrl/user/assign-hospital/$caseId";

  // === Upload API ===
  static const String uploadPhoto = "$baseUrl/upload-api";
}

 **/