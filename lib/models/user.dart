import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import './story.dart';

class User extends GetxController{
  final String username;
  final String profilePic;
  final List<Story> stories;
  RxInt currentIndex;
  bool nextUser;
  int finalIndex;

  User({
    required this.username,
    required this.profilePic,
    required this.currentIndex,
    required this.stories,
    required this.nextUser,
    required this.finalIndex
  });

  VideoPlayerController? videoController;


  void increment(){
    currentIndex++;
    if(finalIndex + 1 < stories.length){
      finalIndex++;
    }
  }
  void decrement(){
    currentIndex--;
  }

}