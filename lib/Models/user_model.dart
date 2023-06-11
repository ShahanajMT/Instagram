class Users {
  final String uid;
  final String username;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  Users({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });


  //Map object where the keys are of type
  Map<String, dynamic> toJson() => {
    "uid": uid,
    "username": username,
    "email": email,
    "bio": bio,
    "photoUrl": photoUrl,
    "followers": followers,
    "following" : following,
  };
}
