import 'package:flutter/material.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Preferences Screen'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen or perform an action
              },
              child: const Text('Go to Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
