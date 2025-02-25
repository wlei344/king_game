import 'package:king_game/common/common.dart';
import 'package:flutter/material.dart';


class SkinListModel {
  List<SkinModel> list;

  SkinListModel({required this.list});

  factory SkinListModel.fromJson(List<dynamic> json) => SkinListModel(
    list: List<SkinModel>.from(json.map((x) => SkinModel.fromJson(x))),
  );

  factory SkinListModel.empty() => SkinListModel(
    list: [],
  );

  Map<String, dynamic> toJson() => {
    'list': List<dynamic>.from(list.map((x) => x.toJson())),
  };

  Future<void> update() async {
    await UserController.to.myDio?.post<SkinListModel>(MyApi.user.listAllSkin,
      onSuccess: (code, msg, data) {
        list = data.list;
      },
      onError: (error) {
      },
      data: {
        "language": UserController.to.localeString,
      },
      onModel: (m) => SkinListModel.fromJson(m),
    );
  }
}

class BagItemListModel {
  List<SkinModel> list;

  BagItemListModel({required this.list});

  factory BagItemListModel.fromJson(List<dynamic> json) => BagItemListModel(
    list: List<SkinModel>.from(json.map((x) => SkinModel.fromJson(x))),
  );

  factory BagItemListModel.empty() => BagItemListModel(
    list: [],
  );

  Map<String, dynamic> toJson() => {
    'list': List<dynamic>.from(list.map((x) => x.toJson())),
  };

  Future<void> update() async {
    await UserController.to.myDio?.get<SkinListModel>(MyApi.user.getBag,
      onSuccess: (code, msg, data) {
        list = data.list;
      },
      onError: (error) {},
      data: {
        "language": UserController.to.localeString,
      },
      onModel: (m) => SkinListModel.fromJson(m),
    );
  }
}

class BoxResultModel {
  bool prizeFlag;
  SkinModel prize;

  BoxResultModel({
    required this.prizeFlag,
    required this.prize,
  });

  Map<String, dynamic> toJson() => {
    'prizeFlag': prizeFlag,
    'prize': prize.toJson(),
  };

  Future<void> update(int type) async {

    String data = 'S';

    if (type == 1) {
      data = 'S+';
    } else if (type == 2) {
      data = 'S++';
    }

    await UserController.to.myDio?.post<BoxResultModel>(MyApi.spinner.boxDraw,
      onSuccess: (code, msg, data) {
        prizeFlag = data.prizeFlag;
        prize = data.prize;
      },
      onError: (e) {
        MyAlert.showSnack(child: Text('${e.error}', style: TextStyle(color: Colors.white)));
      },
      data: {'type': data},
      onModel: (m) => BoxResultModel.fromJson(m),
    );
  }

  factory BoxResultModel.fromJson(Map<String, dynamic> json) => BoxResultModel(
    prizeFlag: json['prizeFlag'] ?? true,
    prize: SkinModel.fromJson(json['prize']),
  );

  factory BoxResultModel.empty() => BoxResultModel(
    prizeFlag: true,
    prize: SkinModel.empty(),
  );
}

class SkinModel {
  int id;
  String createTime;
  String updateTime;
  int deleted;
  String type;
  String name;
  String url;
  String remark;
  int probability;
  int price;
  int winPrice;

  SkinModel({
    required this.id,
    required this.createTime,
    required this.updateTime,
    required this.deleted,
    required this.type,
    required this.name,
    required this.url,
    required this.remark,
    required this.probability,
    required this.price,
    required this.winPrice,
  });

  factory SkinModel.fromJson(Map<String, dynamic> json) => SkinModel(
    id: json["id"] ?? -1,
    createTime: json["createTime"] ?? '',
    updateTime: json["updateTime"] ?? '',
    deleted: json["deleted"] ?? -1,
    type: json["type"] ?? '',
    name: json["name"] ?? '',
    url: json["url"] ?? '',
    remark: json["remark"] ?? '',
    probability: json["probability"] ?? -1,
    price: json["price"] ?? -1,
    winPrice: json["winPrice"] ?? -1,
  );

  factory SkinModel.empty() => SkinModel(
    id: -1,
    createTime: '',
    updateTime: '',
    deleted: -1,
    type: '',
    name: '',
    url: '',
    remark: '',
    probability: -1,
    price: -1,
    winPrice: -1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime,
    "updateTime": updateTime,
    "deleted": deleted,
    "type": type,
    "name": name,
    "url": url,
    "remark": remark,
    "probability": probability,
    "price": price,
    "winPrice": winPrice,
  };
}