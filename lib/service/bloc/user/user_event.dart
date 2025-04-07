abstract class UserEvent {}

class LoadUsersEvent extends UserEvent {}

class FilterUsersEvent extends UserEvent {
  final String query;

  FilterUsersEvent(this.query);
}
