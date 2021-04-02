import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/app_controller.dart';
import 'package:fluttereventsapp/controllers/auth_controller.dart';
import 'package:fluttereventsapp/widgets/events_list.dart';
import 'package:fluttereventsapp/widgets/my_events.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      builder: (app) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Events App'),
            actions: [
              GetBuilder<AuthController>(
                  builder: (auth) => IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        auth.signOut();
                      }))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: app.currentPage,
            onTap: (index) {
              app.togglePage(index);
            },
            items: [
              BottomNavigationBarItem(
                label: "All Events",
                icon: Icon(
                  Icons.list,
                ),
              ),
              BottomNavigationBarItem(
                label: "My Events",
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              app.updateEvent();
            },
            child: Icon(Icons.add),
          ),
          body: app.currentPage == 0 ? EventsList() : MyEvents(),
        ),
      ),
    );
  }
}
