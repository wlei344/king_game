import 'package:king_game/common/common.dart';

class LoginModel {
  String token;
  String secretToken;

  LoginModel({
    required this.token,
    required this.secretToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json['token'] ?? '',
    secretToken: json['secretToken'] ?? '',
  );

  factory LoginModel.empty() => LoginModel(
    token: '',
    secretToken: '',
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'secretToken': secretToken,
  };

  Future<void> login({
    required String account,
    required String code,
    void Function()? onSuccess,
    void Function(String)? onError,
  }) async {
    return UserController.to.myDio?.post<LoginModel>(MyApi.base.login,
      onSuccess: (code, msg, data) {
        token = data.token;
        secretToken = data.secretToken;
        onSuccess?.call();
      },
      onError: (error) {
        onError?.call('${error.error}');
      },
      onModel: (m) => LoginModel.fromJson(m),
      data: {
        'mobile': account,
        'captcha': code,
      }
    );
  }

  Future<void> guestLogin({
    required String deviceId,
    void Function()? onSuccess,
    void Function(String)? onError,
  }) async {
    return UserController.to.myDio?.post<LoginModel>(MyApi.base.guestLogin,
        onSuccess: (code, msg, data) {
          token = data.token;
          secretToken = data.secretToken;
          onSuccess?.call();
        },
        onError: (error) {
          onError?.call('${error.error}');
        },
        onModel: (m) => LoginModel.fromJson(m),
        data: {
          'deviceId': deviceId,
        }
    );
  }
}
