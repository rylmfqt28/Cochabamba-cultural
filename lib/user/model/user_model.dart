class UserModel {
  String? uid;
  String? name;
  String? email;

  UserModel({
    this.uid,
    this.name,
    this.email,
  });

  // Para recibir los datos del servidor
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  // Para enviar datos al servidor
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  copyWith({
    String? uid,
    String? name,
    String? email,
  }) =>
      UserModel(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          email: email ?? this.email);
}
