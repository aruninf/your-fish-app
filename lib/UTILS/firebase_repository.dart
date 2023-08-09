import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dialog_helper.dart';

class FirebaseRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String userCollection = "users";
  final String chatsCollection = "collection_name";

  Future<void> insertData(String chatroomId, Map<String, dynamic> data) async {
    try {
      await _fireStore
          .collection(chatsCollection)
          .doc(chatroomId)
          .collection('message')
          .doc()
          .set(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<String> uploadImage(File? imageFile) async {
    try {
      DialogHelper.showLoading();
      int timestamp = DateTime.now().millisecond;
      Reference ref = FirebaseStorage.instance.ref("/${timestamp}_photo.jpg");
      UploadTask uploadTask = ref.putFile(imageFile!);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      print("uploading image url  == = =  = == = = =${imageUrl.toString()}");
      DialogHelper.hideLoading();
      return imageUrl.toString();
    } catch (e){
      throw Exception(e.toString());
    }

  }

  Future<void> updateData(String status, String user) async {
    try {
      var request = {"status": status};
      await _fireStore.collection(userCollection).doc(user).set(request);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteData(String uid, String id) async {
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

  Stream<QuerySnapshot>? getData(String groupChatId, int limit) {
    try {
      return _fireStore
          .collection(chatsCollection)
          .doc(groupChatId)
          .collection("message")
          .orderBy("timeStamp", descending: true)
          .limit(limit)
          .snapshots();
    } on Exception catch (e) {
      throw Exception(e.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot>? getStatus(String user) {
    try {
      return _fireStore.collection(userCollection).doc(user).snapshots();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }

    /*.get()
        .then((DocumentSnapshot ds) async => await ds["status"]);*/
  }




}