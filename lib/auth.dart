import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return null;
    }
    
    final GoogleSignInAuthentication googleSignInAuthentication = 
        await googleSignInAccount.authentication;
    
    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken, 
        accessToken: googleSignInAuthentication.accessToken,
      );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if(user == null) {
      return null;
    }

    try {
      final idToken = await user.getIdToken();
      assert(idToken != null);
      print('ID Token: $idToken');
    } catch (e) {
      return null;
    }

    assert(!user.isAnonymous);
    return user;
  } catch (e) {
    print('Error during Google sign-in: $e');
    return null;
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}
  /*final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user; 

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser;
  assert(currentUser.uid == user.uid);
  
  return user;
}*/