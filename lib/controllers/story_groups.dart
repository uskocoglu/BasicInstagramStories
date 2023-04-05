import 'package:get/get.dart';
import 'package:getx_new/models/story.dart';
import 'package:getx_new/models/user.dart';

class StoryGroupsController extends GetxController with GetSingleTickerProviderStateMixin{

  int _currentUser = 0;

  final List<User> _users = [
    User(username: 'kingjames',
        profilePic: 'https://www.aljazeera.com/wp-content/uploads/2023/02/2023-02-06T000606Z_1360403070_RC2E3Z9F9UPQ_RTRMADP_3_BASKETBALL-NBA-JAMES.jpg?resize=1800%2C1800.jpg',
        currentIndex: 0.obs,
        finalIndex: 0,
        nextUser: false,
        stories: [
          Story(url: 'https://upload.wikimedia.org/wikipedia/commons/a/a7/LeBron_James_Lakers.jpg', media: MediaType.image, duration: const Duration(seconds: 5)),
          Story(url: 'https://static.videezy.com/system/resources/previews/000/007/602/original/dribbling.mp4', media: MediaType.video, duration: const Duration(seconds: 0)),
          Story(url: 'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2018_27/2484416/180702-lebron-james-cleveland-cavaliers-njs-1217.jpg', media: MediaType.image, duration: const Duration(seconds: 5)),
        ]),
    User(username: 'cristiano',
        profilePic: 'https://i.pinimg.com/474x/4c/fb/06/4cfb06d09f6fafdfa58b759946d21b02.jpg',
        currentIndex: 0.obs,
        finalIndex: 0,
        nextUser: false,
        stories: [
          Story(url: 'https://cdn.ntvspor.net/4574e60ef1a245af916f02fb5cd95b8f.jpg?mode=crop&w=940&h=626', media: MediaType.image, duration: const Duration(seconds: 5)),
          Story(url: 'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/bltee886584fd1cd345/60db8718892a730f5883a347/68a712aa7ffd3da7d91c2fe1469bda58990f7ab7.jpg', media: MediaType.image, duration: const Duration(seconds: 5)),
        ]),
    User(username: 'rihanna',
        profilePic: 'https://imageio.forbes.com/specials-images/imageserve/5ceec355142c500008f42068/Rihanna-Diamond-Ball-Forbes-Women/0x0.jpg?format=jpg&crop=1950,1950,x32,y257,safe&height=1950&width=1950',
        currentIndex: 0.obs,
        finalIndex: 0,
        nextUser: false,
        stories: [
          Story(url: 'https://ia.tmgrup.com.tr/51b2e5/0/0/0/0/2048/2048?u=https://i.tmgrup.com.tr/cr/2022/12/19/rihanna-oglunun-yuzunu-ilk-kez-gosterdi-1671442314067.jpg', media: MediaType.image, duration: const Duration(seconds: 5)),
          Story(url: 'https://wwd.com/wp-content/uploads/2023/02/GettyImages-1465420720.jpg', media: MediaType.image, duration: const Duration(seconds: 5)),
        ]),
  ];


  get users => _users;

  User getUser(int index){
    return _users[index];
  }

  String getUsername(int index){
    return _users[index].username;
  }

  String getProfilePic(int index){
    return _users[index].profilePic;
  }

  List<Story> getStories(int index){
    return _users[index].stories;
  }

  void setCurrentUser(int value){
    _currentUser = value;
  }

  void incrementCurrentUser(){
    _currentUser++;
  }
  get currentUser => _currentUser;
}