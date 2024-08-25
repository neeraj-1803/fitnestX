import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  //Google Sign in
  signInWithGoogle() async {
    //begin the process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new user cred
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //sign in with that cred
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  signInWithApple() async {
    /*final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(credential);*/
  }
}
