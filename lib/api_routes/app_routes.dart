class AppRoutes {
  static const String mapApi = "AIzaSyDaaNW6khrCkxJesgZCZ9lEqGqfPS6373Q";

  static const String baseUrl = "http://fyp.pelarinfruit.com/api";
  static String nearbyHospitalsUrl(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$latitude,$longitude&radius=3500&type=hospital&key=$mapApi';
  }

  // === Auth APIs ===
  static const String userRegister = "$baseUrl/user/register";
  static const String userLogin = "$baseUrl/user/login";
  static String userVerify(String token) => "$baseUrl/user/verify/$token";
  static const String userResendOTP = "$baseUrl/user/resndOTP";
  static const String userForgotPassword = "$baseUrl/user/forgot-password";
  static const String userResetPassword = "$baseUrl/user/reset-password";

  static const String hospitalRegister = "$baseUrl/hospital/register";
  static const String hospitalLogin = "$baseUrl/hospital/login";
  static String hospitalVerify(String otp) => "$baseUrl/hospital/verify/$otp";
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
