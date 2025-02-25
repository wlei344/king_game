import 'package:king_game/common/common.dart';

class UserModel {
  String nickname;
  num balance;
  int id;
  num tickets;
  String accountName;
  String cardNumber;
  String bankName;
  int vndRate;
  String lastLoginTime;
  int status;
  String mobile;
  String avatar;

  UserModel({
    required this.nickname,
    required this.balance,
    required this.id,
    required this.tickets,
    required this.accountName,
    required this.cardNumber,
    required this.bankName,
    required this.vndRate,
    required this.lastLoginTime,
    required this.status,
    required this.mobile,
    required this.avatar,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) => UserModel(
    nickname: json['nickname'] ?? '',
    balance: json['balance'] ?? -1,
    id: json['id'] ?? -1,
    tickets: json['tickets'] ?? -1,
    accountName: json['accountName'] ?? '',
    cardNumber: json['cardNumber'] ?? '',
    bankName: json['bankName'] ?? '',
    vndRate: json['vndRate'] ?? -1,
    lastLoginTime: json['lastLoginTime'] ?? '',
    status: json['status'] ?? -1,
    mobile: json['mobile'] ?? '',
    avatar: json['avatar'] ?? '',
  );

  factory UserModel.empty() => UserModel(
    nickname: '',
    balance: -1,
    id: -1,
    tickets: -1,
    accountName: '',
    cardNumber: '',
    bankName: '',
    vndRate: -1,
    lastLoginTime: '',
    status: -1,
    mobile: '',
    avatar: '',
  );

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'balance': balance,
    'id': id,
    'tickets': tickets,
    'accountName': accountName,
    'cardNumber': cardNumber,
    'bankName': bankName,
    'vndRate': vndRate,
    'lastLoginTime': lastLoginTime,
    'status': status,
    'avatar': avatar,
    'mobile': mobile,
  };
  
  Future<void> update({
    void Function()? onSuccess,
    void Function(String)? onError,
  }) async {
    await UserController.to.myDio?.post<UserModel>(MyApi.user.getInfo,
      onSuccess: (code, msg, data) {
        nickname = data.nickname;
        balance = data.balance;
        id = data.id;
        tickets = data.tickets;
        accountName = data.accountName;
        cardNumber = data.cardNumber;
        bankName = data.bankName;
        vndRate = data.vndRate;
        lastLoginTime = data.lastLoginTime;
        status = data.status;
        avatar = data.avatar;
        mobile = data.mobile;

        onSuccess?.call();
      },
      onError: (error) {
       onError?.call(error.toString());
      },
      onModel: (m) => UserModel.fromJson(json: m)
    );
  }
}
