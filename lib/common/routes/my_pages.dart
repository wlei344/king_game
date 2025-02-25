import 'package:get/get.dart';
import 'package:king_game/common/common.dart';
import 'package:king_game/views/views.dart';

class MyPages {
  // 未知页面
  static final unknownRoute = GetPage(
    name: MyRoutes.unknown,
    page: () => const UnknownView(),
    binding: UnknownBinding(),
  );

  static final List<GetPage> getPages = [
    // 初始页面
    GetPage(
      name: MyRoutes.index,
      page: () => const IndexView(),
      binding: IndexBinding(),
      middlewares: [
        MiddlewareIndex(),
      ],
    ),

    // 登陆页面
    GetPage(
      name: MyRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // Application 主页面
    GetPage(
      name: MyRoutes.application,
      page: () => const ApplicationView(),
      binding: ApplicationBinding(),
    ),

    // 背包
    GetPage(
      name: MyRoutes.bag,
      page: () => const BagView(),
      binding: BagBinding(),
    ),

    // 充值页面
    GetPage(
      name: MyRoutes.recharge,
      page: () => const RechargeView(),
      binding: RechargeBinding(),
    ),

    // 抽奖
    GetPage(
      name: MyRoutes.gameLottery,
      page: () => const LotteryView(),
      binding: LotteryBinding(),
    ),

    // 投注
    GetPage(
      name: MyRoutes.gameBet,
      page: () => const BetView(),
      binding: BetBinding(),
    ),
  ];
}
