part of 'api.dart';

class _Base {
  // 获取配置信息
  final String getConfig = '/basic/config';
  // 发送手机验证码
  final String sendPhoneCode = '/basic/captcha';
  // 登录
  final String login = '/basic/login';
  // 游客登陆
  final String guestLogin = '/basic/loginTourist';
  // 登出
  final String logout = '/basic/logout';
  // 刷新token
  final String refreshToken = '/basic/refresh';
}