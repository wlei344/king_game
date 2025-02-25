import 'package:king_game/common/common.dart';

class BankListModel {
  List<BankModel> list;

  BankListModel({required this.list});

  factory BankListModel.fromJson(List<dynamic> json) => BankListModel(
    list: List<BankModel>.from(json.map((x) => BankModel.fromJson(x))),
  );

  factory BankListModel.empty() => BankListModel(
    list: [],
  );

  Map<String, dynamic> toJson() => {
    'list': List<dynamic>.from(list.map((x) => x.toJson())),
  };

  Future<void> update() async {
    await UserController.to.myDio?.post<BankListModel>(MyApi.user.getBankList,
      onSuccess: (code, msg, data) {
        list = data.list;
      },
      onModel: (m) => BankListModel.fromJson(m),
    );
  }
}

class BankModel {
  final int id;
  final String bankName;
  final String bankCode;

  BankModel({
    required this.id, 
    required this.bankName, 
    required this.bankCode,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    id: json['id'] ?? -1,
    bankName: json['bankName'] ?? "",
    bankCode: json['bankCode'] ?? "",
  );

  factory BankModel.empty() => BankModel(
    id: -1,
    bankName: "",
    bankCode: "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bankName': bankName,
    'bankCode': bankCode,
  };
}
