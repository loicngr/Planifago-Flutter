class User {
  String id;
  Object plan;
  String email;
  Object roles;
  String firstName;
  String lastName;
  String phone;
  bool isActive;
  String avatar;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.plan,
    this.email,
    this.roles,
    this.firstName,
    this.lastName,
    this.phone,
    this.isActive,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      plan: json['plan'],
      email: json['email'],
      roles: json['roles'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      isActive: json['isActive'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}