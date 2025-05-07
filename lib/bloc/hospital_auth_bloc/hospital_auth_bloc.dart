import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'hospital_auth_state.dart';
import 'dart:developer';
import 'dart:convert';

class HospitalAuthBloc extends Bloc<HospitalAuthEvent, HospitalAuthState> {
  HospitalAuthBloc() : super(HospitalInitial()) {
    on<RegisterHospital>(_onRegister);
    // on<LoginHospital>(_onLogin);
    on<VerifyHospitalEmail>(_onVerifyEmail);
    // on<ResendHospitalOtp>(_onResendOtp);
    // on<ForgotHospitalPassword>(_onForgotPassword);
    // on<ResetHospitalPassword>(_onResetPassword);
  }

  Future<void> _onRegister(
      RegisterHospital event, Emitter<HospitalAuthState> emit) async {
    emit(HospitalLoading());
    try {
      final response = await http.post(
        Uri.parse(AppRoutes.hospitalRegister),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'Name': event.name,
          'Email': event.email,
          "Phone": event.phone,
          'Password': event.password,
        }),
      );
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('hospital_auth_token', data['token']);

        emit(HospitalSuccess(message: data['msg']));
      } else {
        emit(HospitalFailure(error: data['msg'] ?? 'Registration failed'));
      }
    } catch (e) {
      emit(HospitalFailure(error: 'Unexpected error occurred: $e'));
      log(e.toString());
    }
  }

//   Future<void> _onLogin(
//       LoginHospital event, Emitter<HospitalAuthState> emit) async {
//     emit(HospitalLoading());
//     try {
//       emit(HospitalSuccess('Login successful'));
//     } catch (e) {
//       emit(HospitalFailure(e.toString()));
//     }
//   }

  Future<void> _onVerifyEmail(
      VerifyHospitalEmail event, Emitter<HospitalAuthState> emit) async {
    emit(HospitalLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('hospital_auth_token');

      final response = await http.get(
        Uri.parse('${AppRoutes.hospitalVerify()}/${event.otp}'),
        headers: {
          'Content-Type': 'application/json',
          'auth-token-hospital': '$token',
        },
      );
      log('Token: $token');
      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(HospitalSuccess(message: data['msg']));
        log("otp verified");
      } else {
        emit(HospitalFailure(error: data['msg'] ?? 'OTP Verification Failed'));
        log(data['msg']);
      }
    } catch (e) {
      emit(HospitalFailure(error: 'Unexpected error occurred: $e'));
      log(e.toString());
    }
  }

//   Future<void> _onResendOtp(
//       ResendHospitalOtp event, Emitter<HospitalAuthState> emit) async {
//     emit(HospitalLoading());
//     try {
//       emit(HospitalSuccess('OTP resent successfully'));
//     } catch (e) {
//       emit(HospitalFailure(e.toString()));
//     }
//   }

//   Future<void> _onForgotPassword(
//       ForgotHospitalPassword event, Emitter<HospitalAuthState> emit) async {
//     emit(HospitalLoading());
//     try {
//       emit(HospitalSuccess('OTP sent for password reset'));
//     } catch (e) {
//       emit(HospitalFailure(e.toString()));
//     }
//   }

//   Future<void> _onResetPassword(
//       ResetHospitalPassword event, Emitter<HospitalAuthState> emit) async {
//     emit(HospitalLoading());
//     try {
//       emit(HospitalSuccess('Password reset successfully'));
//     } catch (e) {
//       emit(HospitalFailure(e.toString()));
//     }
//   }
//
}
