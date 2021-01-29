class Users {

  static information (int uid) {
    final String path = "/api/users/$uid";

    return """
      {
        user(id: "$path") {
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
    """;
  }

  static signUp (Map<String, String> values) {
    final DateTime date = DateTime.now();
    final String dateStr = date.toString();

    final String email = values['email'];
    final String password = values['password'];
    final String firstname = values['firstname'];
    final String lastname = values['lastname'];

    return """
      mutation {
        createUser(input: {
          email: "$email",
          password: "$password",
          firstname: "$firstname",
          lastname: "$lastname",
          roles: ["ROLE_USER"],
          createdAt: "$dateStr",
          updatedAt: "$dateStr",
          isActive: false,
          plan: "/api/plans/1",
        }) {
          clientMutationId
          user {
            id
          }
        }
      }
    """;
  }
}