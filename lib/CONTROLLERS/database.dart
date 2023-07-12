import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yourfish/UTILS/dialog_helper.dart';

class Database {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String userCollection = "users";
  final String chatsCollection = "chats";

  Future<void> sendMessage(String chatroomId, Map<String, dynamic> data) async {
    try {
      await _fireStore
          .collection(chatsCollection)
          .doc(chatroomId)
          .collection('message')
          .doc()
          .set(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteMessage(
      String chatroomId, Map<String, dynamic> data, String docrefrence) async {
    String realRef;
    realRef = docrefrence.replaceAll(
        _fireStore
            .collection(chatsCollection)
            .doc(chatroomId)
            .collection('message')
            .path,
        "");

    realRef = realRef.replaceAll("/", "");
    try {
      await _fireStore
          .collection(chatsCollection)
          .doc(chatroomId)
          .collection('message')
          .doc(realRef)
          .update(data);
    } catch (e) {
      print(e.toString());
    }
  }


  Future<String> uploadImage(File? imageFile) async {
    DialogHelper.showLoading();
    int timestamp = DateTime.now().millisecond;
    Reference ref = FirebaseStorage.instance.ref("/${timestamp}_photo.jpg");
    UploadTask uploadTask = ref.putFile(imageFile!);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    print("uploading image url  == = = == = = = = = = = == = = =${imageUrl.toString()}");
    DialogHelper.hideLoading();
    return imageUrl.toString();
  }

  Future<void> updateStatus(String status, String user) async {
    try {
      var request = {"status": status};
      await _fireStore.collection(userCollection).doc(user).set(request);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateMessageSeenStatus(
      String chatroomId, String docrefrence) async {
    String realRef;
    realRef = docrefrence.replaceAll(
        _fireStore
            .collection(chatsCollection)
            .doc(chatroomId)
            .collection('message')
            .path,
        "");

    realRef = realRef.replaceAll("/", "");
    try {
      var request = {"status": "1"};
      await _fireStore
          .collection(chatsCollection)
          .doc(chatroomId)
          .collection('message')
          .doc(realRef)
          .update(request);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> delete(String uid, String id) async {
    try {
      await _fireStore
          .collection(userCollection)
          .doc(uid)
          .collection(chatsCollection)
          .doc(id)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot>? getChatMessage(String groupChatId, int limit) {
    try {
      return _fireStore
          .collection(chatsCollection)
          .doc(groupChatId)
          .collection("message")
          .orderBy("timeStamp", descending: true)
          .limit(limit)
          .snapshots();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot>? getStatus(String user) {
    try {
      return _fireStore.collection(userCollection).doc(user).snapshots();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }

    /*.get()
        .then((DocumentSnapshot ds) async => await ds["status"]);*/
  }

  Stream<QuerySnapshot>? getLastMessage(String groupChatId) {
    try {
      return _fireStore
          .collection(chatsCollection)
          .doc(groupChatId)
          .collection("message")
          .orderBy("timeStamp", descending: true)
          .limit(1)
          .snapshots();
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }

    /*.get()
        .then((DocumentSnapshot ds) async => await ds["status"]);*/
  }

  Future<bool> isCollectionExits(String groupChatId) async {
    QuerySnapshot<Map<String, dynamic>> queryS = await _fireStore
        .collection(chatsCollection)
        .doc(groupChatId)
        .collection("message")
        .get();

    if (queryS.docs.isNotEmpty) {
      // Collection exits
      print('collection exists ============================');
      return true;
    } else {
      // Collection not exits
      print('collection doesn\'t exists ============================');
      return false;
    }
  }
}

