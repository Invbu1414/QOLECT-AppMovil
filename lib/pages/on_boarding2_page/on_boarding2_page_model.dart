import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_boarding2_page_widget.dart' show OnBoarding2PageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class OnBoarding2PageModel extends FlutterFlowModel<OnBoarding2PageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
