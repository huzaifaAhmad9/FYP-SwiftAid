import 'dart:developer';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:swift_aid/bloc/user_bloc/upload_cubit_state.dart';

class FileUploadCubit extends Cubit<FileUploadState> {
  FileUploadCubit() : super(FileUploadInitial());

  Future<void> uploadFile(String filePath) async {
    emit(FileUploadInProgress());
    log('File upload started');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      log('Token: $token');

      final file = File(filePath);
      log('File to upload: ${file.path}');

      final uri = Uri.parse(AppRoutes.uploadPhoto);
      log('Upload URI: $uri');

      final request = http.MultipartRequest('POST', uri)
        ..headers['auth-token-user'] = '$token'
        ..files.add(await http.MultipartFile.fromPath('photo', file.path));
      log('Headers: ${request.headers}');
      log('Files: ${request.files.map((f) => f.filename).toList()}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final uploadedPath = data['result'];
        log('Uploaded file path: $uploadedPath');
        emit(FileUploadSuccess(filePath: uploadedPath));
      } else {
        log('File upload failed with status: ${response.statusCode}');
        emit(FileUploadFailure(message: 'File upload failed'));
      }
    } catch (e) {
      log('Error during file upload: $e');
      emit(FileUploadFailure(message: 'Error uploading file: $e'));
    }
  }
}
