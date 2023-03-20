class UserModel {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.avatar});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstname: json['first_name'] ?? 'Firstname',
      lastname: json['last_name'] ?? 'Lastname',
      avatar: json['avatar'] ??
          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1679133095~exp=1679133695~hmac=bfb9f0794e417bf5b473a69a4ad3fad18901bbabced4ddc88e4e7cf5ce17347c',
    );
  }
}
