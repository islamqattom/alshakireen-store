class SignUpRequest {
  String name;
  String email;
  String phone;
  String password;

  SignUpRequest(this.name, this.email, this.phone, this.password);

  Map<String, String> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };
}
