import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:retociclo4/domain/models/user_status.dart';

class StatusController extends GetxController {
  var _userStatus = <UserStatus>[].obs;
  final CollectionReference statuses =
      FirebaseFirestore.instance.collection('statuses');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('statuses').snapshots();
  late StreamSubscription<Object?> streamSubscription;
  
  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Got new item from fireStore');
      _userStatus.clear();
      event.docs.forEach((element) {
        _userStatus.add(UserStatus.fromSnapshot(element));
      });
      print('Got ${_userStatus.length}');
    });
  }

  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  List<UserStatus> get entries => _userStatus;

  Future<void> sendStatus(Map<String, dynamic> status) async {
    statuses
        .add(status)
        .then((value) => print("Status added"))
        .catchError((onError) => print("Failed to add Status $onError"));
  }

  Future<void> removeStatus(UserStatus status) async {
    status.reference!.delete();
  }
}