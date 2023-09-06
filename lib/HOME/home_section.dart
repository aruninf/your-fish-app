import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/MODELS/post_response.dart';

import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import 'home/single_post_item.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final postController = Get.find<PostController>();

  final scrollController = ScrollController();

  final searchController = TextEditingController();

  int page = 1;

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        setState(() {
          postController.isLoading.value = true;
          page += 1;
          //add api for load the more data according to new page
          var data = {
            "sortBy": "desc",
            "sortOn": "created_at",
            "page": page,
            "limit": "5",
          };
          postController.getPosts(data);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: CustomSearchField(
              hintText: 'Search',
              controller: searchController,
              onChanges: (p0) {
                var data = {
                  "sortBy": "desc",
                  "sortOn": "created_at",
                  "page": "1",
                  "limit": "20",
                  "filter": searchController.text
                };
                postController.getPosts(data);
              },
            ),
          ),
          Expanded(
              child: Obx(
            () => postController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : postController.postData.isEmpty
                    ? const Center(
                        child: Text(
                          "No Post yet!",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: scrollController,

                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postController.postData.length,
                          addAutomaticKeepAlives: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          itemBuilder: (context, index) => SingleFishPostWidget(
                              postModel: postController.postData[index]),
                        ),
                      ),
          )),
        ],
      ),
    );
  }
}
