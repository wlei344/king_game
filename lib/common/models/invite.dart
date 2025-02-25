import 'package:king_game/common/common.dart';

class InviteModel {
  int inviteUserCount;
  int inviteTickets;
  String inviteUrl;

  InviteModel({
    required this.inviteUserCount,
    required this.inviteTickets,
    required this.inviteUrl,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) => InviteModel(
    inviteUserCount: json["inviteUserCount"],
    inviteTickets: json["inviteTickets"],
    inviteUrl: json["inviteUrl"],
  );

  factory InviteModel.empty() => InviteModel(
    inviteUserCount: 0,
    inviteTickets: 0,
    inviteUrl: '',
  );

  Map<String, dynamic> toJson() => {
    "inviteUserCount": inviteUserCount,
    "inviteTickets": inviteTickets,
    "inviteUrl": inviteUrl,
  };

  Future<void> update() async {
    await UserController.to.myDio?.get<InviteModel>(MyApi.user.getInviteInfo,
      onSuccess: (code, msg, data) {
        inviteUserCount = data.inviteUserCount;
        inviteTickets = data.inviteTickets;
        inviteUrl = data.inviteUrl;
      },
      onModel: (m) => InviteModel.fromJson(m),
    );
  }
}