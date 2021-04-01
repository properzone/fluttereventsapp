import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttereventsapp/pages/root_page.dart';
import 'package:fluttereventsapp/services/auth_services.dart';
import 'package:get/get.dart';

enum AuthState {
  loading,
  loggedin,
}

class AuthController extends GetxController {
  Rx<AuthState> _authState = AuthState.loading.obs;

  AuthState get authState => this._authState.value;
  set authState(AuthState value) => this._authState.value = value;

  late UserCredential userCredential;
  late User? user;
  @override
  void onInit() async {
    authState = AuthState.loading;
    await Future.delayed(Duration(seconds: 0));
    user = AuthServices.getUser();
    if (user == null) {
      userCredential = await AuthServices.anonymousLogin();
      Get.snackbar("Success!", "New User Logged In!");
      await Future.delayed(Duration(seconds: 1));
    } else {
      Get.snackbar("Success!", "User Logged in");
      await Future.delayed(Duration(seconds: 1));
    }
    Get.to(() => RootPage());
    authState = AuthState.loggedin;
    super.onInit();
  }
}
