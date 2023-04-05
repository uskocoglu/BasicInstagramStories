import 'package:get/get.dart';
import 'package:video_player/video_player.dart';



class MyVideoController extends GetxController{

  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    videoPlayerController = null;
    videoPlayerController?.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController?.dispose();
  }


}