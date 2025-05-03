abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignupEvent(this.name, {required this.email, required this.password});
}

class VerifyOtpEvents extends AuthEvent {
  final String otp;
  VerifyOtpEvents(this.otp);
}

class GoogleSignInEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String newpassword;
  ResetPasswordEvent({required this.newpassword});
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;
  ForgetPasswordEvent({required this.email});
}
