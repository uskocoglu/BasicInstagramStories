import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new/controllers/anim_controller.dart';
import 'package:getx_new/controllers/page_controller.dart';
import 'package:getx_new/controllers/video_controller.dart';
import 'package:getx_new/controllers/story_groups.dart';
import 'package:getx_new/screens/stories.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final StoryGroupsController _storyGroupsController =
      Get.put(StoryGroupsController());
  final MyPageController _myPageController = Get.put(MyPageController());
  final _animationController = Get.lazyPut(() => AnimController());
  final _videPlayerController = Get.lazyPut(() => MyVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Instagram Stories',
          style: TextStyle(
              fontFamily: 'AveriaLibre', fontSize: 28, color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _storyGroupsController.users.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(0, 4, 7, 0),
                    child: _storyGroupsController.getUser(index).finalIndex +
                                1 <
                            _storyGroupsController.getStories(index).length
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: 45,
                              child: ClipOval(
                                child: GestureDetector(
                                  onTap: () {
                                    //o indexteki user ın storylerini göreceği ekrana gidecek
                                    Get.to(Stories(), arguments: index);
                                  },
                                  child: Image.network(_storyGroupsController
                                      .getProfilePic(index)),
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              child: ClipOval(
                                child: GestureDetector(
                                  onTap: () {
                                    //o indexteki user ın storylerini göreceği ekrana gidecek
                                    Get.to(Stories(), arguments: index);
                                  },
                                  child: Image.network(_storyGroupsController
                                      .getProfilePic(index)),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Text(_storyGroupsController.getUsername(index),
                      style: const TextStyle(
                          fontFamily: 'AveriaLibre',
                          fontSize: 18,
                          color: Colors.black)),
                ],
              );
            }),
      ),
    );
  }
}
