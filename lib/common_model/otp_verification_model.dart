import 'package:mawqifi_driver/common_model/profile_model.dart';

class OtpVerificationModel {
  OtpVerificationModel(
      {required this.isValid, required this.token, required this.profile});

  final bool isValid;
  final String? token;
  final ProfileModel? profile;

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      OtpVerificationModel(
        isValid: json['is_valid'],
        token: json['token'],
        profile: (json['drive'] != null)
            ? ProfileModel.fromJson(json['drive'])
            : null,
      );
}
