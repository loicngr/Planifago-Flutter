/*
------------- GraphQl request --------------
{
    users {
    	edges {
        node {
          id,
    			plan { id },
          email,
          roles,
          firstname,
          lastname,
          phone,
          isActive,
          avatar,
          createdAt,
          updatedAt
        }
      }
  	}
}
 */

class Users {
  final List<User> user;

  Users(this.user);

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(json['user']);
  }
}

class User {
  final int id;
  final int planId;
  final String email;
  final Object roles;
  final String firstName;
  final String lastName;
  final String phone;
  final bool isActive;
  final String avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    this.planId,
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
      planId: json['planId'],
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