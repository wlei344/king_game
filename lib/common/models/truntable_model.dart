import 'package:flutter/material.dart';
import 'package:king_game/common/common.dart';

class TurntablePrizeListModel {
  List<TurntablePrizeModel> list;

  TurntablePrizeListModel({required this.list});

  factory TurntablePrizeListModel.fromJson(List<dynamic> json) => TurntablePrizeListModel(
    list: List<TurntablePrizeModel>.from(json.map((x) => TurntablePrizeModel.fromJson(x))),
  );

  factory TurntablePrizeListModel.empty() => TurntablePrizeListModel(
    list: [
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 1,
        amount: 0,
      ),
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 2,
        amount: 0,
      ),
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 3,
        amount: 0,
      ),
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 4,
        amount: 0,
      ),
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 5,
        amount: 0,
      ),
      TurntablePrizeModel(
        id: -1,
        type: -1,
        no: 6,
        amount: 0,
      ),
    ],
  );

  Map<String, dynamic> toJson() => {
    'list': List<dynamic>.from(list.map((x) => x.toJson())),
  };

  Future<void> update(int type) async {
    await UserController.to.myDio?.post<TurntablePrizeListModel>(MyApi.spinner.getTurntablePrizes,
      onSuccess: (code, msg, data) {
        list = data.list;
      },
      data: {'type': type},
      onModel: (m) => TurntablePrizeListModel.fromJson(m),
    );
  }
}

class TurntableResultModel {
  bool prizeFlag;
  TurntablePrizeModel prize;

  TurntableResultModel({
    required this.prizeFlag,
    required this.prize,
  });

  Map<String, dynamic> toJson() => {
    'prizeFlag': prizeFlag,
    'prize': prize.toJson(),
  };

  Future<void> update(int type) async {
    await UserController.to.myDio?.post<TurntableResultModel>(MyApi.spinner.turntableDraw,
      onSuccess: (code, msg, data) {
        prizeFlag = data.prizeFlag;
        prize = data.prize;
      },
      onError: (e) {
        MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
      },
      data: {'type': type},
      onModel: (m) => TurntableResultModel.fromJson(m),
    );
  }

  factory TurntableResultModel.fromJson(Map<String, dynamic> json) => TurntableResultModel(
    prizeFlag: json['prizeFlag'] ?? true,
    prize: TurntablePrizeModel.fromJson(json['prize']),
  );

  factory TurntableResultModel.empty() => TurntableResultModel(
    prizeFlag: true,
    prize: TurntablePrizeModel.empty(),
  );
}

class TurntablePrizeModel {
  int id;
  int type;
  int no;
  int amount;

  TurntablePrizeModel({
    required this.id,
    required this.type,
    required this.no,
    required this.amount,
  });

  factory TurntablePrizeModel.fromJson(Map<String, dynamic> json) => TurntablePrizeModel(
    id: json['id'] ?? -1,
    type: json['type'] ?? -1,
    no: json['no'] ?? -1,
    amount: json['amount'] ?? 0,
  );

  factory TurntablePrizeModel.empty() => TurntablePrizeModel(
    id: -1,
    type: -1,
    no: -1,
    amount: 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'no': no,
    'amount': amount,
  };


}
