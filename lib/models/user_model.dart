class User {
  String userID = "Empty";
  String username = "Empty";
  String email = "Empty";

//internal constructor
  User._internalConstructor();

//singleton object
  static final _singleObject = User._internalConstructor();

//override default Constructor
  factory User() {
    return _singleObject;
  }

  setFromMap(Map<String, dynamic> userMapped) {
    this.email = userMapped["email"];
    this.userID = userMapped["userID"];
    this.username = userMapped["username"];
  }

  clearUser() {
    this.email = "Empty";
    this.userID = "Empty";
    this.username = "Empty";
  }

  String getCurrentUser() {
    return userID;
  }

  //just in case of new creation
  setUsername(String _username) {
    this.username = _username;
  }
}
