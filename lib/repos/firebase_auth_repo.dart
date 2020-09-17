import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'model/user.dart';

class FirebaseAuthRepo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepo({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  Future<User> getUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return User(
      userid: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
      username: firebaseUser.displayName,
      imageUrl: firebaseUser.photoUrl,
    );
  }

  Future<User> signInUsingGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);

    return getUser();
  }

  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
