import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_state.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';

class CustomDialogue extends StatelessWidget {
  const CustomDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthloadingState) {
          return _buildDialog(
            context,
            content: const Row(
              children: [
                Spacer(),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
                Spacer(),
              ],
            ),
            title: "Loading...",
          );
        }

        if (state is AuthSucessState) {
          log("Success state triggered");
          return _buildDialog(
            context,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.message, // Dynamically show the success message
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                2.heightBox,
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primaryColor,
                  size: 50.0,
                ),
              ],
            ),
            title: "Success",
          );
        }

        if (state is AuthErrorState) {
          return _buildDialog(
            context,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                2.heightBox,
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50.0,
                ),
              ],
            ),
            title: "Error",
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildDialog(BuildContext context,
      {required Widget content, required String title}) {
    return AlertDialog(
      title: Text(title),
      content: content,
    );
  }
}
