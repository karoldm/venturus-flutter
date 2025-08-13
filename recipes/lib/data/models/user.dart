class UserProfile {
  final String id;
  final String username;
  final String avatarUrl;
  final String email;

  UserProfile({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String,
      email: json['email'] as String,
    );
  }

  factory UserProfile.fromSupabase(
    Map<String, dynamic> userData,
    Map<String, dynamic> profileData,
  ) {
    return UserProfile(
      id: userData['id'] ?? '',
      email: userData['email'] ?? '',
      username: profileData['username'] as String,
      avatarUrl: profileData['avatar_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, username: $username, avatarUrl: $avatarUrl, email: $email)';
  }
}
