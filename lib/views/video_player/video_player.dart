import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/const.dart';
import 'package:peeker/utils/route_manager.dart';
import 'package:peeker/views/Comment/comment_screen.dart';
import 'package:peeker/views/video_player/widgets/video_player_item.dart';

import '../../controller/video_controller.dart';
import '../../utils/layout.dart';
import '../widgets/circle_animation.dart';

class VideoPlayer extends StatelessWidget {
  VideoPlayer({super.key});

  final VideoController _videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: Layout.getWidth(60),
      height: Layout.getHeight(60),
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: Layout.getWidth(50),
              height: Layout.getHeight(50),
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: Layout.getWidth(60),
      height: Layout.getHeight(60),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: Layout.getHeight(50),
            width: Layout.getWidth(50),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.grey,
                    ColorManager.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: _videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = _videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(
                      videoUrl: _videoController.videoList[index].videoUrl),
                  Column(
                    children: [
                      Gap(100),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.caption,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: ColorManager.white,
                                        ),
                                        Text(
                                          data.songName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: Layout.getWidth(100),
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(data.thumbnail),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            _videoController.likeVideo(data.id),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 34,
                                          color: data.likes.contains(
                                                  authController.user.uid)
                                              ? ColorManager.secondaryColor
                                              : ColorManager.white,
                                        ),
                                      ),
                                      Gap(3),
                                      Text(
                                        data.likes.length.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: ColorManager.white),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                              id: data.id,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.comment,
                                          size: 34,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                      const Gap(3),
                                      Text(
                                        data.commentCount.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.reply,
                                          size: 34,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                      Gap(3),
                                      Text(
                                        data.shareCount.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: ColorManager.white),
                                      ),
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMusicAlbum(data.profilePhoto),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
