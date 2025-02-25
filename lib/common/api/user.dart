part of 'api.dart';

class _User {
  // 用户信息
  final String getInfo = '/user/info';
  // 更新用户信息
  final String updateInfo = '/user/update';
  // 钻石兑换抽奖券
  final String exchangeDiamond = '/user/exchange';
  // 获取商城信息
  final String listAllSkin = '/user/listAllSkin';
  // 兑换皮肤
  final String redeemSkin = '/user/redeemSkin';
  // 获取邀请好友的信息
  final String getInviteInfo = '/user/invite';
  // 获取好友列表
  final String getInviteFriends = '/user/inviteUser';
  // 背包
  final String getBag = '/user/bag';
  // 支付下单
  final String payOrder = '/user/payOrder';
  // 获取银行列表
  final String getBankList = '/user/bankList';
  // 修改银行卡信息
  final String updateBankInfo = '/user/updateBank';
}