class User {
    User({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
    });

    String id;
    String email;
    String firstName;
    String lastName;
    String avatar;

    factory User.createUserFromAPI(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
    );
}