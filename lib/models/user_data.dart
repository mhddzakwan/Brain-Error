class UserData {
  final String name;

  UserData({required this.name});

  String get greeting {
    if (name.isEmpty) return 'Halo!';
    return 'Halo, $name!';
  }
}
