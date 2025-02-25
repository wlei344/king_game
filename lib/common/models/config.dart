import 'package:king_game/common/common.dart';

class ConfigModel {
  int boxAmountS;
  int boxAmountSs;
  int boxAmountSss;
  int spinnerAmountSilver;
  int spinnerAmountGold;
  int spinnerAmountDiamond;

  ConfigModel({
    required this.boxAmountSs,
    required this.boxAmountSss,
    required this.spinnerAmountSilver,
    required this.spinnerAmountGold,
    required this.spinnerAmountDiamond,
    required this.boxAmountS,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    boxAmountSs: json['boxAmountSs'] ?? -1,
    boxAmountSss: json['boxAmountSss'] ?? -1,
    spinnerAmountSilver: json['spinnerAmountSilver'] ?? -1,
    spinnerAmountGold: json['spinnerAmountGold'] ?? -1,
    spinnerAmountDiamond: json['spinnerAmountDiamond'] ?? -1,
    boxAmountS: json['boxAmountS']  ?? -1,
  );

  factory ConfigModel.empty() => ConfigModel(
    boxAmountSs: -1,
    boxAmountSss: -1,
    spinnerAmountSilver: -1,
    spinnerAmountGold: -1,
    spinnerAmountDiamond: -1,
    boxAmountS: -1,
  );

  Map<String, dynamic> toJson() => {
    'boxAmountSs': boxAmountSs,
    'boxAmountSss': boxAmountSss,
    'spinnerAmountSilver': spinnerAmountSilver,
    'spinnerAmountGold': spinnerAmountGold,
    'spinnerAmountDiamond': spinnerAmountDiamond,
    'boxAmountS': boxAmountS,
  };
  
  Future<void> update() async {
    await UserController.to.myDio?.get<ConfigModel>(MyApi.base.getConfig,
      onSuccess: (code, msg, data) {
        boxAmountS = data.boxAmountS;
        boxAmountSs = data.boxAmountSs;
        boxAmountSss = data.boxAmountSss;
        spinnerAmountSilver = data.spinnerAmountSilver;
        spinnerAmountGold = data.spinnerAmountGold;
        spinnerAmountDiamond = data.spinnerAmountDiamond;
      },
      onError: (error) {
      },
      onModel: (m) => ConfigModel.fromJson(m),
    );
  }
}
