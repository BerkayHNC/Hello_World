import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      print('Google Sign In was canceled by user');
      return null;
    }
    
    // Debug print to check Google account info
    print('Google Account Email: ${googleSignInAccount.email}');
    print('Google Account Display Name: ${googleSignInAccount.displayName}');
    
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
      print('Failed to sign in: user is null');
      return null;
    }

    // Debug print to check Firebase user info
    print('Firebase User Display Name: ${user.displayName}');
    print('Firebase User Email: ${user.email}');

    // Verify user is not anonymous and has a name
    assert(!user.isAnonymous);
    assert(user.displayName != null);

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