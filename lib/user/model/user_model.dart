class UserModel {
  String? uid;
  String? name;
  String? email;
  String? picture;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.picture,
  });

  // Para recibir los datos del servidor
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        picture: map['picture']);
  }

  // Para enviar datos al servidor
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'picture': picture,
    };
  }

  copyWith({
    String? uid,
    String? name,
    String? email,
    String? picture,
  }) =>
      UserModel(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          email: email ?? this.email,
          picture: picture ?? this.picture);
}
