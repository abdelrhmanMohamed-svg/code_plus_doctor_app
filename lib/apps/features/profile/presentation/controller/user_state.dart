/// Immutable state for the user session.
class UserState {
  const UserState({this.name = '', this.isLoading = false});

  final String name;
  final bool isLoading;

  UserState copyWith({String? name, bool? isLoading}) => UserState(
    name: name ?? this.name,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  bool operator ==(Object other) =>
      other is UserState && other.name == name && other.isLoading == isLoading;

  @override
  int get hashCode => Object.hash(name, isLoading);
}
