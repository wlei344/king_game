import 'package:king_game/common/common.dart';

class SignInModel {
  int firstDayOfWeek;
  int omissions;
  Map<String, dynamic> continuous;
  Map<String, dynamic> signInTree;

  SignInModel({
    required this.firstDayOfWeek,
    required this.omissions,
    required this.continuous,
    required this.signInTree,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    firstDayOfWeek: json['firstDayOfWeek'] ?? -1,
    omissions: json['omissions'] ?? -1,
    continuous: json['continuous'] ?? {},
    signInTree: json['signInTree'] ?? {},
  );

  factory SignInModel.empty() => SignInModel(
    firstDayOfWeek: 0,
    omissions: 0,
    continuous: {},
    signInTree: {},
  );

  Future<void> update() async {
    await UserController.to.myDio?.get<SignInModel>(MyApi.signIn.getSingInInfo,
      onSuccess: (code, msg, data) {
        firstDayOfWeek = data.firstDayOfWeek;
        omissions = data.omissions;
        continuous = data.continuous;
        signInTree = data.signInTree;
      },
      onError: (error) {
      },
      onModel: (m) => SignInModel.fromJson(m),
    );
  }
}
