class UserProfile {
  String? id;
  String? name;
  String? email;
  String? password;
  String? fcmToken;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.password,
    this.fcmToken,
  });

  UserProfile.fromJson(Map<String, dynamic> json, this.id) {
    name = json['name'];
    email = json['email'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['fcmToken'] = fcmToken;
    return data;
  }
}
