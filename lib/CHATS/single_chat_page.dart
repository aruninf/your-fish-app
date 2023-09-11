import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/UTILS/app_color.dart';

import '../CONTROLLERS/database.dart';
import 'bottom_composer.dart';
import 'chat_app_bar.dart';
import 'chat_item_row.dart';
import 'chat_model.dart';

/// Created by arun android

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({
    Key? key,
    required this.receiver,
    this.image,
    this.matchName,
  }) : super(key: key);
  final ReceiverModel? receiver;
  final String? image;
  final String? matchName;

  @override
  State<SingleChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<SingleChatPage> with WidgetsBindingObserver {
  var postController = Get.put(PostController());
  var controller = Database();
  File? imageFile;
  int _limit = 20;
  final int _limitIncrement = 20;
  bool isShowSticker = false;
  int messageType = 1;
  List<QueryDocumentSnapshot> listMessages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  String? userStatus;
  Timer? _timer;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        controller.updateStatus(
            "online", "${postController.userData.value.id}");
      },
    );
    super.initState();
    focusNode.addListener(onFocusChanged);
    scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addObserver(this);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
          stream: controller.getChatMessage(
              "${widget.receiver?.matchRoomId}", _limit),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              listMessages = snapshot.data!.docs;
              if (listMessages.isNotEmpty) {
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: listMessages.length,
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      ChatResult chatMessages =
                          ChatResult.fromDocument(listMessages[index]);
                      if (chatMessages.receiverId ==
                          "${postController.userData.value.id}") {
                        updateSeen(listMessages[index].reference.path);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChatItemRow(
                          userId: "${postController.userData.value.id}",
                          documentSnapshot: listMessages[index],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('No messages...'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<void> updateSeen(String docrefrence) async {
    controller.updateMessageSeenStatus(
        widget.receiver?.matchRoomId ?? "", docrefrence);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 75),
          child: CustomChatAppBar(
            title: widget.matchName ?? '',
            image: widget.image ?? '',
            backPress: onBackPress,
            chatRoomId: widget.receiver?.matchRoomId ?? '',
            userId: widget.receiver?.receiverId ?? '',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              buildListMessage(),
              messageType == 2
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.file(
                                imageFile == null
                                    ? File("")
                                    : File(imageFile!.path),
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                width: double.infinity,
                              ),
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color:
                                      primaryColor, //Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                  //boxShadow: Constants.fixShadow()
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            messageType = 1;
                                            imageFile = null;
                                          });
                                        },
                                        color: Colors.white,
                                        icon: const Icon(
                                          Icons.close_sharp,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        color: Colors.white,
                                        onPressed: imageMessageSendClick,
                                        icon: const Icon(
                                          Icons.send_rounded,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                    )
                  : Column(
                      children: [

                        BottomComposer(
                            file: imageFile == null
                                ? File("")
                                : File(imageFile!.path),
                            widget: TextField(
                              controller: _textController,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 3,
                              maxLength: 250,
                              minLines: 1,
                              style: const TextStyle(fontSize: 14,color: btnColor),
                              decoration: InputDecoration(
                                  counterText: "",

                                  hintStyle: const TextStyle(color: Colors.grey),
                                  hintText: "Send a message",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(width: 0.56,color: btnColor)

                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(width: 0.56,color: btnColor)

                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(width: 0.56,color: btnColor)

                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 4),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(width: 0.56,color: btnColor)

                                  ),

                              ),

                              onChanged: (String text) async {
                                if (text.isNotEmpty) {
                                  if (userStatus != "typing") {
                                    userStatus = "typing";
                                    controller.updateStatus("typing",
                                        "${postController.userData.value.id}");
                                  }
                                  const duration = Duration(seconds: 1);

                                  if (_timer != null) {
                                    _timer!.cancel();
                                  }

                                  _timer = Timer(duration, () {
                                    //print("userStatus updating online");
                                    userStatus = "online";

                                    controller.updateStatus("online",
                                        "${postController.userData.value.id}");
                                  });
                                }
                              },
                              onSubmitted: (value) {
                                //_sendMessage(value, 1);
                              },
                            ),
                            pickFileClick: () {
                              _bottomSheet(context);
                            },
                            sendClick: sendClick),
                        Builder(builder: (BuildContext context) {
                          return const SizedBox(width: 0.0, height: 0.0);
                        })
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress() async {
    await controller.updateStatus(
        "Offline", "${postController.userData.value.id}");
    return Future.value(true);
  }

  imageMessageSendClick() async {
    if (messageType == 2) {
      await uploadImage(imageFile!);
    }
    setState(() {});
  }

  sendClick() async {
    _sendMessage(_textController.text, messageType);
    setState(() {});
  }

  Future<void> _sendMessage(String message, int messageType) async {
    if (message.trim().isEmpty) return;
    String ids = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    var req = ChatResult(
      id: ids,
      senderId: "${postController.userData.value.id}",
      receiverId: "${widget.receiver?.receiverId}",
      messageType: messageType,
      message: message.trim(),
      chatroomId: "${widget.receiver?.matchRoomId}",
      senderName: "${postController.userData.value.name}",
      senderProfile: "${postController.userData.value.profilePic}",
      status: "0",
      timeStamp: ids,
      isDeleted: false,
    ).toJson();
    _textController.clear();
    // var param = {
    //   "receiverId": widget.receiver?.matchRoomId,
    //   "message": messageType == 2 ? "📷" : message.trim(),
    //   "matchId": widget.receiver!.receiverId
    // };
    controller.sendMessage("${widget.receiver?.matchRoomId}", req);
    //NotificationController.sendMsgNotification(param);
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<void> uploadImage(File? image) async {
    var url = await controller.uploadImage(image!);
    _sendMessage(url.toString(), messageType);
    setState(() {
      messageType = 1;
    });
  }

  imageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 2160, maxWidth: 2160);
    // .getImage(source: ImageSource.gallery, maxHeight: 600, maxWidth: 400);
    if (pickedFile != null) {
      getImagePath(pickedFile);
    }
  }

  imageFromCamera() async {
    await Permission.camera.request();
    var cameraPermission = await Permission.camera.status;
    if (cameraPermission.isPermanentlyDenied || cameraPermission.isDenied) {
      openAppSettings();
      return;
    }
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 2160, maxWidth: 2160);
    // .getImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 400);
    if (pickedFile != null) {
      getImagePath(pickedFile);
    }
  }

  void getImagePath(XFile pickedFile) {
    setState(() {
      messageType = 2;
      imageFile = File(pickedFile.path);
    });
    Navigator.pop(context);
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      useRootNavigator: true,
      // set shape to make top corners rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close_sharp),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: imageFromCamera,
                    child: const Text('Open Camera'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: imageFromGallery,
                    child: const Text('Open Gallery'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.updateStatus("Offline", "${postController.userData.value.id}");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.updateStatus("Offline", "${postController.userData.value.id}");
    } else if (state == AppLifecycleState.resumed) {
      controller.updateStatus("online", "${postController.userData.value.id}");
    }
    super.didChangeAppLifecycleState(state);
  }
}
