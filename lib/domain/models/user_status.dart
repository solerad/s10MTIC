import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatus {
  String picUrl, name, email, message;
  final DocumentReference? reference;

  UserStatus({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    this.reference
  });

  UserStatus.fromMap(Map<String, dynamic> data, {required this.reference})
      : assert(data['email'] != null),
        assert(data['message'] != null),
        picUrl = data['picUrl'],
        name = data['name'],
        email = data['email'],
        message = data['message'];

  UserStatus.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    return {
      "picUrl": picUrl,
      "name": name,
      "email": email,
      "message": message,
    };
  }
}