abstract class HospitalAuthEvent {}

class RegisterHospital extends HospitalAuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterHospital(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});
}

class LoginHospital extends HospitalAuthEvent {
  final String email;
  final String password;

  LoginHospital({required this.email, required this.password});
}

class VerifyHospitalEmail extends HospitalAuthEvent {
  final String otp;

  VerifyHospitalEmail(this.otp);
}

class ResendHospitalOtp extends HospitalAuthEvent {}

class ForgotHospitalPassword extends HospitalAuthEvent {
  final String email;

  ForgotHospitalPassword(this.email);
}

class ResetHospitalPassword extends HospitalAuthEvent {
  final String otp;
  final String newPassword;

  ResetHospitalPassword({required this.otp, required this.newPassword});
}
