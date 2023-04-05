import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_new/controllers/story_groups.dart';
import 'package:getx_new/widgets/user_info.dart';

import '../controllers/anim_controller.dart';
import 'animated_bar.dart';

class ImageView extends StatelessWidget {
  final int index;
  final AnimController animController = Get.find();


  ImageView({Key? key, required this.index}) : super(key: key);

  final StoryGroupsController _storyGroups = Get.find();


  @override
  Widget build(BuildContext context) {
    animController.startAnimation(_storyGroups.getStories(index)[_storyGroups.getUser(index).currentIndex.value]);
    return Stack(
      children: [
        PageView(
          children: [
            CachedNetworkImage(
              imageUrl: _storyGroups
                  .getStories(index)[_storyGroups
                  .getUser(index)
                  .currentIndex
                  .value]
                  .url,
              fit: BoxFit.cover,
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
                _storyGroups.getStories(index)
                    .asMap()
                    .map((key, value) {
                  return MapEntry(
                    key,
                    AnimatedBar(
                      animController: animController.animController,
                      position: key,
                      currentIndex: _storyGroups.getUser(index).currentIndex.value,

                    ),
                  );
                }).values.toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1.5,
                  vertical: 10.0,
                ),
                child: UserInfo(user: _storyGroups.users[index]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
