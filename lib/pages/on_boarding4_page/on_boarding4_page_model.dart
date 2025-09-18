import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_boarding4_page_widget.dart' show OnBoarding4PageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class OnBoarding4PageModel extends FlutterFlowModel<OnBoarding4PageWidget> {
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
