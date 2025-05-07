abstract class FileUploadState {}

class FileUploadInitial extends FileUploadState {}

class FileUploadInProgress extends FileUploadState {}

class FileUploadSuccess extends FileUploadState {
  final String filePath;
  FileUploadSuccess({required this.filePath});
}

class FileUploadFailure extends FileUploadState {
  final String message;
  FileUploadFailure({required this.message});
}
