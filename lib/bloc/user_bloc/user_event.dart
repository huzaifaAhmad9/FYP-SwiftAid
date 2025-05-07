abstract class UserEvent {}

class FetchUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final Map<String, dynamic> updatedData;
  UpdateUserEvent({required this.updatedData});
}
