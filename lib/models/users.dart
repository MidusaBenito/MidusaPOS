import 'package:json_annotation/json_annotation.dart';
import 'package:midusa_pos/models/user_data.dart';
part 'users.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String userId;
  List<UserData> user_details;
  User({
    required this.userId,
    required this.user_details,
  });
  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
