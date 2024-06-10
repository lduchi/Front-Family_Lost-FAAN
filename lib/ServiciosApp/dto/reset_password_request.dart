class ResetPasswordRequest {
  String newPassword;
  String newRepeatedPassword;

  ResetPasswordRequest(
      {required this.newPassword, required this.newRepeatedPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newPassword'] = this.newPassword;
    data['newRepeatedPassword'] = this.newRepeatedPassword;
    return data;
  }
}
