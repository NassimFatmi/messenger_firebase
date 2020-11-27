import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/models/appuser.dart';
import 'package:messenger/screens/services/database.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser createAppUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // get AppUser
  Stream<AppUser> get user {
    return _auth.userChanges().map(createAppUser);
  }

  // Methode for sign in with email and password
  Future signinWithEmailandPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return createAppUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Register with new account

  Future createNewAccount(
      String email, String password, String userName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DataBaseServices(uid: user.uid).updateData(userName);
      return createAppUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Methode to sign out

  Future logOut() async {
    return await _auth.signOut();
  }
}
