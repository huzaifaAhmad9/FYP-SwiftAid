abstract class HospitalAuthState {}

class HospitalInitial extends HospitalAuthState {}

class HospitalLoading extends HospitalAuthState {}

class HospitalSuccess extends HospitalAuthState {
  final String message;

  HospitalSuccess({required this.message});
}

class HospitalFailure extends HospitalAuthState {
  final String error;

  HospitalFailure({required this.error});
}
