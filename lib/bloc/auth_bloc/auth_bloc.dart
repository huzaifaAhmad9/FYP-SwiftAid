import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_evetns.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' show log;
import 'dart:convert';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitialState()) {
    on<SignupEvent>((event, emit) async {
      emit(AuthloadingState());

      try {
        final response = await http.post(
          Uri.parse(AppRoutes.userRegister),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'Name': event.name,
            'Email': event.email,
            'Password': event.password,
          }),
        );
        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');

        final data = json.decode(response.body);

        if (response.statusCode == 201) {
          // Save token in local storage
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', data['token']);

          emit(AuthSucessState(message: data['msg']));
        } else {
          emit(AuthErrorState(message: data['msg'] ?? 'Registration failed'));
        }
      } catch (e) {
        emit(AuthErrorState(message: 'Unexpected error occurred: $e'));
        log(e.toString());
      }
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthloadingState());
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          emit(AuthErrorState(message: 'Google sign-in was canceled.'));
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        User? user = userCredential.user;
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', user.uid);

          final userSnapshot = await _db.child('users/${user.uid}').get();
          if (!userSnapshot.exists) {
            await _db.child('users/${user.uid}').set({
              'name': googleUser.displayName,
              'email': googleUser.email,
              'createdAt': DateTime.now().toIso8601String(),
            });
          }
          emit(UserAuthenticatedState(user: user));
          emit(AuthSucessState(message: 'Google sign-in successful!'));
        } else {
          emit(AuthErrorState(message: 'Failed to sign in with Google.'));
        }
      } catch (e) {
        emit(AuthErrorState(message: 'Error during Google sign-in: $e'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthloadingState());
      try {
        final response = await http.post(
          Uri.parse(AppRoutes.userLogin),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'Email': event.email,
            'Password': event.password,
          }),
        );
        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
        final data = json.decode(response.body);

        if (response.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', data['token']);

          emit(AuthSucessState(message: data['msg'] ?? 'Login successful'));
        } else {
          emit(AuthErrorState(message: data['msg'] ?? 'Login failed'));
        }
      } catch (e) {
        log("Unexpected error: $e");
        emit(AuthErrorState(message: 'Unexpected error: $e'));
      }
    });
    on<ForgetPasswordEvent>((event, emit) async {
      emit(AuthloadingState());

      try {
        final response = await http.post(
          Uri.parse(AppRoutes.userForgotPassword),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'Email': event.email.trim()}),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final message = responseData['msg'];
          final newAuthToken = responseData['token'];

          final prefs = await SharedPreferences.getInstance();

          await prefs.remove('auth_token');

          
          await prefs.setString('auth_token', newAuthToken);

          emit(AuthSucessState(message: message));
        } else {
          emit(AuthErrorState(
            message: responseData['msg'] ?? 'Something went wrong',
          ));
        }
      } catch (e) {
        emit(AuthErrorState(message: 'Unexpected error occurred: $e'));
      }
    });

    on<VerifyOtpEvents>((event, emit) async {
      try {
        emit(AuthloadingState());
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');

        final response = await http.get(
          Uri.parse('${AppRoutes.userVerify()}/${event.otp}'),
          headers: {
            'Content-Type': 'application/json',
            'auth-token-user': '$token',
          },
        );

        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');

        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          emit(AuthSucessState(message: data['msg']));
          log("otp verified");
        } else {
          emit(AuthErrorState(
              message: data['msg'] ?? 'OTP Verification Failed'));
          log(data['msg']);
        }
      } catch (e) {
        emit(AuthErrorState(message: 'Unexpected error occurred: $e'));
        log(e.toString());
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(AuthloadingState());
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        final response = await http.post(
          Uri.parse(
              AppRoutes.userResetPassword), // replace with your actual endpoint
          headers: {
            'Content-Type': 'application/json',
            'auth-token-user': '$token',
          },
          body: jsonEncode({
            'otp': event.otp,
            'newPassword': event.password,
          }),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          emit(AuthSucessState(message: responseData['msg']));
        } else {
          emit(AuthErrorState(
              message: responseData['msg'] ?? 'Password reset failed.'));
        }
      } catch (e) {
        emit(AuthErrorState(message: 'Unexpected error: $e'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthloadingState());
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');

        await _auth.signOut();
        emit(AuthSucessState(message: 'Logged out successfully.'));
        log(prefs.getString('auth_token')!);
      } catch (e) {
        emit(AuthErrorState(message: 'Unexpected error occurred: $e'));
      }
    });
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }
}
