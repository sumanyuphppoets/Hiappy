import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../config/env.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Sign out from any previous session to avoid issues
      await GoogleSignIn().signOut();

      // Trigger Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User cancelled the sign-in

      // Get auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser && user != null) {
        // Store user info and role in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        print("✅ New Google user signed up: ${user.email}");
      } else {
        print("🔑 Google user signed in: ${user?.email}");
      }

      return userCredential;
    } catch (e) {
      print("❌ Google sign-in error: ${e.toString()}");
      return null;
    }
  }
 
  static Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.tokenString;
        final credential = FacebookAuthProvider.credential(accessToken);
        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print("Facebook sign-in error: $e");
    }
    return null;
  }

  static Future<UserCredential?> signInWithApple() async {
    if (!Platform.isIOS) return null;
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthCredential = OAuthProvider(
        "apple.com",
      ).credential(idToken: appleCredential.identityToken);

      return await _auth.signInWithCredential(oAuthCredential);
    } catch (e) {
      print("Apple sign-in error: $e");
      return null;
    }
  }

static final String _signupUrl = '${AppEnv.baseUrl}/HiappySignup';
static final String _loginUrl = '${AppEnv.baseUrl}/HiappyLogin';
static final String _googleloginUrl = '${AppEnv.baseUrl}/HiappygoogleLogin';

  static Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(_signupUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return _handleResponse(response);
  }

   static Future<Map<String, dynamic>> googlelogin(String email) async {
    final response = await http.post(
      Uri.parse(_googleloginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
      }),
    );

    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response res) {
    final body = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return {'success': true, 'data': body};
    } else {
      return {'success': false, 'error': body['error'] ?? 'Unknown error'};
    }
  }


}
