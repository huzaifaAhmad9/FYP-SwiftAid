import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_aid/bloc/user_bloc/user_state.dart';
import 'package:swift_aid/bloc/user_bloc/user_event.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:swift_aid/Models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' show log;
import 'dart:convert';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<FetchUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        final response = await http.get(Uri.parse(AppRoutes.userProfile),
            headers: {'auth-token-user': '$token'});
        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final userModel = UserModel.fromJson(jsonData);
          emit(UserLoadedState(userModel: userModel));
        } else {
          final errorMsg =
              json.decode(response.body)['msg'] ?? 'Failed to fetch user data';
          emit(UserErrorState(message: errorMsg));
        }
      } catch (e) {
        emit(UserErrorState(message: 'Failed to fetch user data $e'));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        log("Updating user data: ${event.updatedData}");
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        final response = await http.put(Uri.parse(AppRoutes.userProfile),
            headers: {'auth-token-user': '$token'},
            body: json.encode(event.updatedData));

        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final userModel = UserModel.fromJson(jsonData);
          emit(UserLoadedState(userModel: userModel));
        } else {
          final errorMsg =
              json.decode(response.body)['msg'] ?? 'Failed to update user data';
          emit(UserErrorState(message: errorMsg));
        }
      } catch (e) {
        emit(UserErrorState(message: 'Failed to update user data $e'));
      }
    });
  }
}
