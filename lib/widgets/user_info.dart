import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_new/controllers/story_groups.dart';

import '../main.dart';
import '../models/user.dart';

class UserInfo extends StatelessWidget {

  final User user;
  final StoryGroupsController _storyGroups = Get.find();

  UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius:20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.profilePic,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight:  FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            List<User> users = _storyGroups.users;
            for(int i=0; i<users.length; i++){
              users[i].currentIndex.value = users[i].finalIndex;
            }
            Get.offAll(MyHomePage());
          }
        )
      ],
    );
  }
}
