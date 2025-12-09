import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Future

  Future<void> register(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    await _firestore.collection(
      'users'
    ).doc(
      cred.user!.uid
    ).set(
      {
        'uid':cred.user!.uid,
        'email':email,
        'role':'user', // Default
        'createdAt': FieldValue.serverTimestamp(),
      }
    );
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}