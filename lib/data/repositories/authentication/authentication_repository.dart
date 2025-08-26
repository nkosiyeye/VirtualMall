import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_store/data/repositories/user/user_respository.dart';
import 'package:flutter_store/features/authentication/screens/login/login.dart';
import 'package:flutter_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:flutter_store/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter_store/features/personalization/controllers/user_controller.dart';
import 'package:flutter_store/features/shop/screens/delivery/order_list.dart';
import 'package:flutter_store/navigation_menu.dart';
import 'package:flutter_store/utils/constants/enums.dart';
import 'package:flutter_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:flutter_store/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../firebase_api.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();
    // Redirect to the appropriate screen
    screenRedirect();
  }
  /// Function to Show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // Initialize User Specific Storage
        await TLocalStorage.init(user.uid);
        final userRepository = Get.put(UserRepository());
        var userDetails = await userRepository.fetchUserDetails(user.uid);


        if(userDetails.role.isNotEmpty && userDetails.role == UserType.delivery.toString()){
          // Initialize User specific token
          Get.offAll(() => const OrderList());

        }else{
          Get.offAll(() => const NavigationMenu());
        }
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // Check if its the first time using app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /*-----------------------Email & Password sign-in ---------------------------- */
  /// [EmailAuthentication] -- SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailAuthentication] -- REGISTER
  // Todo: Add custom Exception video 36 8:00 and video 42 12:16
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailAuthentication] -- Mail Verification
  Future<void> sendEmailVerification() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailAuthentication] -- FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [ReAuthentication] -- ReAuthenticate user
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try{
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /*------------------ ./ end Federated identity & social sign-in -------------------*/
  /// [GoogleAuthentication] -- Google
  /// [FacebookAuthentication] -- Facebook

  /// [LogoutUser] -- Valid for any information
  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [DeleteUser] -- Remove user Auth and Firestore Account
  Future<void> deleteAccount() async{
    try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

}
