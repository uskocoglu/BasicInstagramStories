import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_new/controllers/page_controller.dart';
import 'package:getx_new/widgets/video.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import '../controllers/anim_controller.dart';
import '../controllers/video_controller.dart';
import '../main.dart';
import '../models/story.dart';
import '../controllers/story_groups.dart';
import '../models/user.dart';
import '../transformers/transformers.dart';
import '../widgets/image.dart';

class Stories extends StatelessWidget {
  final StoryGroupsController _storyGroups = Get.find();
  final AnimController _animController = Get.find();
  final MyPageController _pageController = Get.find();
  final MyVideoController _videoController = Get.find();


  double _screenWidth() {
    var pixelRatio = window.devicePixelRatio;

    //Size in logical pixels
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;

    //Safe area paddings in logical pixels
    var paddingLeft = window.padding.left / window.devicePixelRatio;
    var paddingRight = window.padding.right / window.devicePixelRatio;

    //Safe area in logical pixels
    var safeWidth = logicalWidth - paddingLeft - paddingRight;
    return safeWidth;
  }

  void _onTapDown(TapDownDetails details, int i) {
    final double screenWidth = _screenWidth();
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if (_storyGroups.getUser(i).currentIndex.value - 1 >= 0) {
        _storyGroups.getUser(i).decrement();
      }
      else{
        _animController.startAnimation(_storyGroups.getStories(i)[_storyGroups.getUser(i).currentIndex.value]);
      }
    }
    else if (dx > 2 * screenWidth / 3) {
      if (_storyGroups.getUser(i).currentIndex.value + 1 < _storyGroups.getStories(i).length) {
        _storyGroups.getUser(i).increment();
      }
      else {
        if(_storyGroups.currentUser + 1 < _storyGroups.users.length){
          _pageController.pageController?.nextPage(duration: const Duration(seconds: 2), curve: Curves.easeInOut);
        }
        else{
          List<User> users = _storyGroups.users;
          for(int i=0; i<users.length; i++){
            users[i].currentIndex.value = users[i].finalIndex;
          }
          Get.offAll(MyHomePage());
        }
      }
    }

    else {
      if (_storyGroups.getStories(i)[_storyGroups.getUser(i).currentIndex.value].media == MediaType.video){
        if (_videoController.videoPlayerController!.value.isPlaying){
          _videoController.videoPlayerController?.pause();
          _animController.animController.stop();
        }
      }
      else{
        if (_animController.animController.isAnimating == true){
          _animController.animController.stop();
        }
      }
    }

  }

  void _onTapUp (TapUpDetails details, int i){

    if (_storyGroups.getStories(i)[_storyGroups.getUser(i).currentIndex.value].media == MediaType.video){
      if (_videoController.videoPlayerController!.value.isPlaying == false){
        _videoController.videoPlayerController?.play();
        _animController.animController.forward();
      }
    }
    else{
      if (_animController.animController.isAnimating == false){
        _animController.animController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _pageController.setInitialPage(Get.arguments);
    return Scaffold(
      body: TransformerPageView(
        pageController: _pageController.pageController,
        index: Get.arguments,
        itemCount: _storyGroups.users.length,
        itemBuilder: (BuildContext context, ind) {
          _storyGroups.setCurrentUser(ind);
          return Obx(() => _storyGroups
                .getStories(
                  ind)[_storyGroups.getUser(ind).currentIndex.value]
                  .media ==
                  MediaType.image
                    ? Scaffold(
                      body: GestureDetector(
                        onTapDown: (details) => _onTapDown(details, ind),
                        onTapUp: (details) => _onTapUp(details, ind),
                        child: ImageView(index: ind),
                  ),
                )
                    : Scaffold(
                      body: GestureDetector(
                        onTapDown: (details) => _onTapDown(details, ind),
                        onTapUp: (details) => _onTapUp(details, ind),
                        child: VideoView(story: _storyGroups.getStories(ind)[_storyGroups.getUser(ind).currentIndex.value], index: ind),
                ),
            ),
          );
        },
        onPageChanged: (int i) {
          _storyGroups.setCurrentUser(i);
        },
        transformer: ThreeDTransformer(),
      ),
    );
  }
}
