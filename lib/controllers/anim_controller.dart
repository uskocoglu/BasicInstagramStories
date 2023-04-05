import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new/controllers/page_controller.dart';
import 'package:getx_new/controllers/story_groups.dart';

import '../main.dart';
import '../models/story.dart';
import '../models/user.dart';

class AnimController extends GetxController
    with GetSingleTickerProviderStateMixin {
  
  late AnimationController animController;
  final StoryGroupsController _s = Get.find();
  final MyPageController _pageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(vsync: this);

    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.stop();
        animController.reset();
        if (_s.getUser(_s.currentUser).currentIndex.value + 1 <
            _s.getStories(_s.currentUser).length) {
          _s.getUser(_s.currentUser).increment();
        }
        else{
          if(_s.currentUser + 1 < _s.users.length){
            _pageController.pageController?.nextPage(duration: const Duration(seconds: 2), curve: Curves.easeInOut);
          }
          else{
            List<User> users = _s.users;
            for(int i=0; i<users.length; i++){
              users[i].currentIndex.value = users[i].finalIndex;
            }
            Get.offAll(MyHomePage());
          }

        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    animController.dispose();
  }

  startAnimation(Story story) {
    animController.stop();
    animController.reset();

    if (story.media == MediaType.image) {
      animController.duration = story.duration;
      animController.forward();
    }

  }
}
