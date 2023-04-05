import 'package:get/get.dart';
import 'package:getx_new/controllers/story_groups.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../models/story.dart';

class MyPageController extends GetxController{

  TransformerPageController? pageController;
  final StoryGroupsController _storyGroupsController = Get.find();

  @override
  void onInit() {
    super.onInit();
    pageController = TransformerPageController();

  }

  void setInitialPage(int index){
    pageController = TransformerPageController(initialPage: index, itemCount: _storyGroupsController.users.length);
  }

}