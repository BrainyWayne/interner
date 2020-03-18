import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

//
// import '../model/firestore.dart';

class DatabaseService with ChangeNotifier {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  int rebuild = 1;
  // Product Configuration
  // Stream<List<FOOD>> _products;
  // Stream<List<FOOD>> get products => _products;
  // set roducts(Stream<List<FOOD>> data) {
  //   _products = data;

  //   notifyListeners();
  // }

  /* simple query to get all products */
  // Stream<List<FOOD>> getProducts({String collection, int limit}) {
  //   var ref =
  //       _db.collection('$collection').orderBy('timeStamp', descending: true);
  //   // .limit(limit);
  //   // .orderBy('timeStamp', descending: false);

  //   var p = ref.snapshots().map((list) =>
  //       list.documents.map((doc) => FOOD.fromFirestore(doc)).toList());

  //   print('Making Request again-${rebuild++} $collection ===> ${p.length}');
  //   return roducts = p;
  // }

  // Stream<List<NOTIFICATION>> _notifications;
  // Stream<List<NOTIFICATION>> get notifications => _notifications;
  // set otifications(Stream<List<NOTIFICATION>> data) {
  //   _notifications = data;

  //   notifyListeners();
  // }

  // /* simple query to get all products */
  // Stream<List<NOTIFICATION>> getNotifications({String collection, int limit}) {
  //   var ref =
  //       _db.collection('$collection').orderBy('timeStamp', descending: true);
  //   // .limit(limit);
  //   // .orderBy('timeStamp', descending: false);

  //   var p = ref.snapshots().map((list) =>
  //       list.documents.map((doc) => NOTIFICATION.fromFirestore(doc)).toList());

  //   print('Making request again-${rebuild++} $collection ===>');
  //   return otifications = p;
  // }

  Future<void> unsubscribeToNotification(channel) {
    print('unsubscribeToNotification');
    return _fcm.unsubscribeFromTopic(channel);
  }

  Future<void> subscribeToNotification(channel) {
    print('subscribeToNotification');

    return _fcm.subscribeToTopic(channel);
  }

  saveDeviceToken() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await _fcm.subscribeToTopic('general');
    String _fcmToken = await _fcm.getToken();

    if (_fcmToken != null) {
      var tokenRef = _db.collection('users').document(user.uid);

      await tokenRef.setData({
        'name': user.displayName,
        'email': user.email,
        'verified': user.isEmailVerified,
        'phone': user.phoneNumber,
        'photo': user.photoUrl,
      }, merge: true);

      await tokenRef.collection('tokens').document(_fcmToken).setData({
        'token': _fcmToken,
        'device': Platform.operatingSystem,
        'createdAt': FieldValue.serverTimestamp(),
        'device_name': Platform.localeName,
      });
    }
  }

  deleteProduct(id) async {
    var ref = _db.collection('products').document(id).delete();
    return ref;
  }

  // saveUserFavorite({@required userId, @required FIREPRODUCT product}) {
  //   var ref = _db.collection('favorites');

  //   ref.
  // }

}
// 233500065504
