import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_new/controllers/anim_controller.dart';
import 'package:getx_new/controllers/video_controller.dart';
import 'package:getx_new/widgets/user_info.dart';
import 'package:video_player/video_player.dart';

import '../models/story.dart';
import '../controllers/story_groups.dart';
import 'animated_bar.dart';

class VideoView extends StatefulWidget {
  final Story story;
  final int index;
  const VideoView({Key? key, required this.story, required this.index}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView>{

  final StoryGroupsController _storyGroups = Get.find();
  final MyVideoController _videoController = Get.find();
  final AnimController _animController = Get.find();


  @override
  void initState() {
    _animController.animController.stop();
    _animController.animController.reset();
    _videoController.videoPlayerController = VideoPlayerController.network(widget.story.url)
      ..initialize().then((_) {
        setState((){});
        if (_videoController.videoPlayerController!.value.isInitialized){
          _animController.animController.duration = _videoController.videoPlayerController?.value.duration;
          _videoController.videoPlayerController?.play();
          _animController.animController.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
            PageView(
              children: [
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                      width: _videoController.videoPlayerController?.value.size.width,
                      height: _videoController.videoPlayerController?.value.size.height,
                      child: VideoPlayer(_videoController.videoPlayerController!)
                  ),
                ),
              ],
        ),
        Positioned(
          top: 40.0,
          left: 10.0,
          right: 10.0,
          child: Column(
            children: [
              Row(
                children:
                _storyGroups.getStories(widget.index)
                    .asMap()
                    .map((key, value) {
                  return MapEntry(
                    key,
                    AnimatedBar(
                      animController: _animController.animController,
                      position: key,
                      currentIndex: _storyGroups.getUser(widget.index).currentIndex.value,

                    ),
                  );
                }).values.toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1.5,
                  vertical: 10.0,
                ),
                child: UserInfo(user: _storyGroups.users[widget.index]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
