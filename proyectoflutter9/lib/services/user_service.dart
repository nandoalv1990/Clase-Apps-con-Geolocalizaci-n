import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<AppUser> getUser(String uid) async {
    final snap = await _db.collection('users').doc(uid).get();
    return AppUser.fromMap(snap.data()!);
  }
}