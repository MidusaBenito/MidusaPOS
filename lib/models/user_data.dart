import 'package:json_annotation/json_annotation.dart';
part 'user_data.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  String firstName, lastName, phoneNumber, role, password;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    required this.password,
  });
  factory UserData.fromJson(Map<String, dynamic> data) =>
      _$UserDataFromJson(data);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
