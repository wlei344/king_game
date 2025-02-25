part of 'theme.dart';

class MyIcons {
  MyIcons._internal();

  static MyAssets get logo => MyAssets(name: 'logo', style: MyAssetStyle.png);


  static AssetImage get loginBackground => MyAssets.image('login_background');
  static MyAssets get loginEmail => MyAssets(name: 'login_email', style: MyAssetStyle.svg);
  static MyAssets get loginPhone => MyAssets(name: 'login_phone', style: MyAssetStyle.svg);
  static MyAssets get loginGoogle => MyAssets(name: 'login_google', style: MyAssetStyle.svg);
  static MyAssets get loginFacebook => MyAssets(name: 'login_facebook', style: MyAssetStyle.svg);
  static MyAssets get loginGuest => MyAssets(name: 'login_guest', style: MyAssetStyle.svg);

  static MyAssets get footerLeftIcon => MyAssets(name: 'footer_left_icon', style: MyAssetStyle.svg);
  static MyAssets get footerRightIcon => MyAssets(name: 'footer_right_icon', style: MyAssetStyle.svg);
  static MyAssets get footerSelected => MyAssets(name: 'footer_selected', style: MyAssetStyle.png);
  static MyAssets get footerGames => MyAssets(name: 'footer_games', style: MyAssetStyle.png);
  static MyAssets get footerStore => MyAssets(name: 'footer_store', style: MyAssetStyle.png);
  static MyAssets get footerMine => MyAssets(name: 'footer_mine', style: MyAssetStyle.png);

  static MyAssets get headerAdd1 => MyAssets(name: 'header_add_1', style: MyAssetStyle.svg);
  static MyAssets get headerAdd2 => MyAssets(name: 'header_add_2', style: MyAssetStyle.svg);
  static MyAssets get headerAvatarBackground => MyAssets(name: 'header_avatar_background', style: MyAssetStyle.svg);
  static MyAssets get headerBackground1 => MyAssets(name: 'header_background_1', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fill,);
  static MyAssets get headerBackground2 => MyAssets(name: 'header_background_2', style: MyAssetStyle.png, fit: BoxFit.fill,);
  static MyAssets get headerCard => MyAssets(name: 'header_card', style: MyAssetStyle.svg);
  static MyAssets get headerStone => MyAssets(name: 'header_stone', style: MyAssetStyle.svg);
  static MyAssets get headerAvatar => MyAssets(name: 'header_avatar', style: MyAssetStyle.png);
  static AssetImage get headerBackground => MyAssets.image('header_background');

  static AssetImage get gameBackground => MyAssets.image('game_background');
  static AssetImage gameBanner(int index) => MyAssets.image('game_banner_$index');
  static MyAssets gamePicture1(int index) => MyAssets(name: 'game_${index}_1', style: MyAssetStyle.png, fit: BoxFit.fill);
  static MyAssets gamePicture2(int index) => MyAssets(name: 'game_${index}_2', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fitWidth);
  static MyAssets gameIcon(int index) => MyAssets(name: 'game_${index}_icon', style: MyAssetStyle.png);
  static MyAssets gameTitle(int index) => MyAssets(name: 'game_${index}_title', style: MyAssetStyle.png);
  static MyAssets get gameTimer => MyAssets(name: 'game_timer', style: MyAssetStyle.png);

  static MyAssets storeSkinLevel(int index) => MyAssets(name: 'store_skin_level_$index', style: MyAssetStyle.png);
  static MyAssets storeSkin(String index) => MyAssets(name: 'store_skin_$index', style: MyAssetStyle.png);
  static MyAssets get storeBanner1 => MyAssets(name:'store_banner_1', style: MyAssetStyle.png);
  static MyAssets get storeBannerBackground => MyAssets(name:'store_banner_background', style: MyAssetStyle.png);
  static MyAssets storeBuy(int index) => MyAssets(name:'store_buy_$index', style: MyAssetStyle.png);
  static MyAssets get storeItemBackground => MyAssets(name:'store_item_background', style: MyAssetStyle.png);
  static MyAssets get storeTitleIcon => MyAssets(name:'store_title_icon', style: MyAssetStyle.png);

  static MyAssets get meButtonTopLeft => MyAssets(name:'me_button_top_left', style: MyAssetStyle.png);
  static MyAssets get meButtonTopRight => MyAssets(name:'me_button_top_right', style: MyAssetStyle.png);
  static MyAssets get meButtonBottomLeft => MyAssets(name:'me_button_bottom_left', style: MyAssetStyle.png);
  static MyAssets get meButtonBottomRight => MyAssets(name:'me_button_bottom_right', style: MyAssetStyle.png);
  static MyAssets get meButtonBottomIcon => MyAssets(name:'me_button_bottom_icon', style: MyAssetStyle.png);

  static MyAssets get switchOn => MyAssets(name:'switch_on', style: MyAssetStyle.png);
  static MyAssets get switchOff => MyAssets(name:'switch_off', style: MyAssetStyle.png);
  static MyAssets get close => MyAssets(name:'close', style: MyAssetStyle.png);

  static AssetImage get alertBodyBackground =>  MyAssets.image('alert_body_background');
  static MyAssets get alertHeaderCenter => MyAssets(name:'alert_header_center', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fill);
  static MyAssets get alertHeaderLeft => MyAssets(name:'alert_header_left', style: MyAssetStyle.png);
  static MyAssets get alertHeaderRight => MyAssets(name:'alert_header_right', style: MyAssetStyle.png);
  static MyAssets get alertHeaderTopLeft => MyAssets(name:'alert_header_top_left', style: MyAssetStyle.png);
  static MyAssets get alertHeaderTopRight => MyAssets(name:'alert_header_top_right', style: MyAssetStyle.png);
  static MyAssets get alertBottomLeft1 => MyAssets(name:'alert_bottom_left_1', style: MyAssetStyle.png);
  static MyAssets get alertBottomLeft2 => MyAssets(name:'alert_bottom_left_2', style: MyAssetStyle.png);
  static MyAssets get alertBottomCenter => MyAssets(name:'alert_bottom_center', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fill);
  static MyAssets get alertBottomRight1 => MyAssets(name:'alert_bottom_right_1', style: MyAssetStyle.png);
  static MyAssets get alertBottomRight2 => MyAssets(name:'alert_bottom_right_2', style: MyAssetStyle.png);
  static MyAssets get alertBackground => MyAssets(name:'alert_background', style: MyAssetStyle.png);
  static MyAssets get alertFailed => MyAssets(name:'alert_failed', style: MyAssetStyle.png);

  static MyAssets get langChecked => MyAssets(name:'lang_checked', style: MyAssetStyle.png);
  static MyAssets get langCn => MyAssets(name:'lang_cn', style: MyAssetStyle.png);
  static MyAssets get langEn => MyAssets(name:'lang_en', style: MyAssetStyle.png);
  static MyAssets get langVn => MyAssets(name:'lang_vn', style: MyAssetStyle.png);

  static MyAssets get settingButtonAudio => MyAssets(name:'setting_button_audio', style: MyAssetStyle.png);
  static MyAssets get settingButtonLang => MyAssets(name:'setting_button_lang', style: MyAssetStyle.png);
  static MyAssets get settingButtonLoginOut => MyAssets(name:'setting_button_login_out', style: MyAssetStyle.png);
  static MyAssets get settingButtonVersion => MyAssets(name:'setting_button_version', style: MyAssetStyle.png);

  static MyAssets get signInDay => MyAssets(name:'sign_in_day', style: MyAssetStyle.png);
  static MyAssets get signInMiss => MyAssets(name:'sign_in_miss', style: MyAssetStyle.png);
  static MyAssets get signInNote => MyAssets(name:'sign_in_note', style: MyAssetStyle.png);
  static MyAssets get signInAlreadyWinIcon => MyAssets(name:'sign_in_already_win_icon', style: MyAssetStyle.png);
  static MyAssets get signInNeverWinIcon => MyAssets(name:'sign_in_never_win_icon', style: MyAssetStyle.png);
  static MyAssets get signInTitle => MyAssets(name:'sign_in_title', style: MyAssetStyle.png);
  static MyAssets signInWin(String index) => MyAssets(name: 'sign_in_win_$index', style: MyAssetStyle.png);
  static MyAssets get signInWinDay => MyAssets(name:'sign_in_win_day', style: MyAssetStyle.png);

  static MyAssets get inviteAlreadyBackground => MyAssets(name:'invite_already_background', style: MyAssetStyle.png);
  static MyAssets get inviteAlreadyCount => MyAssets(name:'invite_already_count', style: MyAssetStyle.png);
  static MyAssets get inviteButton0 => MyAssets(name:'invite_button_0', style: MyAssetStyle.png);
  static MyAssets get inviteButton1 => MyAssets(name:'invite_button_1', style: MyAssetStyle.png);
  static MyAssets get inviteHeaderIcon => MyAssets(name:'invite_header_icon', style: MyAssetStyle.png);
  static MyAssets get inviteRecharged => MyAssets(name:'invite_recharged', style: MyAssetStyle.png);
  static MyAssets get inviteRegister => MyAssets(name:'invite_register', style: MyAssetStyle.png);
  static MyAssets get inviteUrl => MyAssets(name:'invite_url', style: MyAssetStyle.png);
  static MyAssets get inviteUrlBackgroundLeft => MyAssets(name:'invite_url_background_left', style: MyAssetStyle.png);
  static MyAssets get inviteUrlBackgroundRight => MyAssets(name:'invite_url_background_right', style: MyAssetStyle.png);
  static MyAssets get inviteUrlBackgroundMiddle => MyAssets(name:'invite_url_background_middle', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fill);
  static MyAssets get inviteUrlCopy => MyAssets(name:'invite_url_copy', style: MyAssetStyle.png);
  static MyAssets get inviteUrlShare => MyAssets(name:'invite_url_share', style: MyAssetStyle.png);
  static MyAssets get inviteWinIconLeft => MyAssets(name:'invite_win_icon_left', style: MyAssetStyle.png);
  static MyAssets get inviteWinIconRight => MyAssets(name:'invite_win_icon_right', style: MyAssetStyle.png);
  static MyAssets get inviteWinIconMiddle => MyAssets(name:'invite_win_icon_middle', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fill);

  static MyAssets get back => MyAssets(name: 'back', style: MyAssetStyle.png);
  static MyAssets get bag => MyAssets(name: 'bag', style: MyAssetStyle.png);
  static MyAssets get editCancel => MyAssets(name: 'edit_cancel', style: MyAssetStyle.png);
  static MyAssets get editSure => MyAssets(name: 'edit_sure', style: MyAssetStyle.png);
  static MyAssets get editUserInfo => MyAssets(name: 'edit_user_info', style: MyAssetStyle.png);

  static MyAssets get lotteryBackground => MyAssets(name: 'lottery_background', style: MyAssetStyle.png, width: double.infinity, height: double.infinity, fit: BoxFit.fill);
  static MyAssets get lotteryTurntable => MyAssets(name: 'lottery_turntable', style: MyAssetStyle.png);
  static MyAssets get lotteryBody => MyAssets(name: 'lottery_body', style: MyAssetStyle.png);
  static MyAssets get lotteryPointer => MyAssets(name: 'lottery_pointer', style: MyAssetStyle.png);
  static MyAssets get lotteryButton0 => MyAssets(name: 'lottery_button_0', style: MyAssetStyle.png);
  static MyAssets get lotteryButton1 => MyAssets(name: 'lottery_button_1', style: MyAssetStyle.png);
  static MyAssets get lotteryButton2 => MyAssets(name: 'lottery_button_2', style: MyAssetStyle.png);
  static MyAssets get turntableWin => MyAssets(name: 'turntable_win', style: MyAssetStyle.png);
  static MyAssets get boxBackground => MyAssets(name: 'box_background', style: MyAssetStyle.png, width: double.infinity, height: double.infinity, fit: BoxFit.fill);
  static MyAssets lotteryHeaderButton(int index) => MyAssets(name: 'lottery_header_button_$index', style: MyAssetStyle.png, width: double.infinity, fit: BoxFit.fitWidth,);

  static MyAssets get gameHelp => MyAssets(name: 'game_help', style: MyAssetStyle.png);
  static MyAssets get gameTeam => MyAssets(name: 'game_team', style: MyAssetStyle.png);

  static MyAssets get gameLeft => MyAssets(name: 'game_left', style: MyAssetStyle.png);
  static MyAssets get gameRight => MyAssets(name: 'game_right', style: MyAssetStyle.png);

}