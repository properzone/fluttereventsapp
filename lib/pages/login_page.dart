import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<AuthController>(
              builder: (auth) => auth.authState == AuthState.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ),
            SizedBox(height: 32.0),
            Text(
              'Waiting for 2 fake seconds\nbecause firebase is so fast\n😃',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
