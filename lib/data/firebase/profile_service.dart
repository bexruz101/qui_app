import 'package:firebase_auth/firebase_auth.dart';

import '../universal_data.dart';

class ProfileService {
  Future<UniversalData> updateUserEmail({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      return UniversalData(data: 'Updated!');
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> updateUserName({
    required String username,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      return UniversalData(data: 'Updated!');
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
}
