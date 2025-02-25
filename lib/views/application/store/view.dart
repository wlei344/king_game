import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_game/common/common.dart';

import 'controller.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
      builder: (controller) {
        return _buildBody(context, controller);
      }
    );
  }

  Widget _buildBody(BuildContext context, StoreController controller) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: MyIcons.gameBackground, fit: BoxFit.fill),
          // color: Color(0xFF36374C),
        ),
        child: Column(children: [
          buildHeader(context),
          Expanded(
            child: Column(children: [
              Expanded(child: Obx(() => GridView.count(
                padding: EdgeInsets.all(10),
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 223 / 354,
                children: controller.state.skins.value.list.map((item) => buildSkinItem(
                  onPressed: () {
                    buildSkinInfoDialog(item);
                  },
                  skinData: item,
                )).toList()
              ))),
              SafeArea(child: SizedBox(height: MyConfig.app.bottomHeight)),
            ])
          ),
        ]),
      ),
    );
  }
}
