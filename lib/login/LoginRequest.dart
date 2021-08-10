class LoginRequest {
  String phone;
  String password;

  LoginRequest(this.phone, this.password);

  Map<String, String> toJson() => {
        "phone": phone,
        "password": password,
      };
}
