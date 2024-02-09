import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../universal_data.dart';

class AuthService {
  Future<UniversalData> signUpUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      return UniversalData(data: "Logged Out");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
}
