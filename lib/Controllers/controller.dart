import 'package:get/get.dart';

class Controller extends GetxController{
  var scrollOffsetGet = 0.0.obs;

  void setScroolOffset(double scrollOffset){
    scrollOffsetGet.value = scrollOffset;
    update();
  }
}