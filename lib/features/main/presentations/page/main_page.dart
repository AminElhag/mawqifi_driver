import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mawqifi_driver/common/color-extension.dart';
import 'package:mawqifi_driver/common/globs.dart';
import 'package:mawqifi_driver/common/permissions_manger.dart';
import 'package:mawqifi_driver/features/booking/presentation/page/booking_list_page.dart';
import 'package:mawqifi_driver/features/proflie/presentations/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 1;
  bool hasNewNotifications = Random().nextBool();

  final pages = [
    BookingListPage(typeId: BookingType.completedRequest.typeId),
    /*const SearchPage(),*/
    BookingListPage(typeId: BookingType.waiting.typeId),
    const ProfilePage()
  ];

  Future<void> _getToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final deviceToken = await _fcm.getToken();
    Globs.udStringSet(deviceToken ?? "", PreferenceKey.fcmToken);
    print("token = " + deviceToken.toString());
  }

  @override
  void initState() {
    _getToken();
    PermissionsManger.askForNotificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      pageIndex = pageIndex;
    });
    return Scaffold(
      appBar: ((pageIndex == 0)
          ? AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                "Completed",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          : (pageIndex == 1)
              ? AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    "New",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )
              : (pageIndex == 3)
                  ? null
                  : AppBar(
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      title: const Text(
                        "Profile",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? const Icon(
                          Icons.local_parking,
                          size: 35,
                        )
                      : Icon(
                          Icons.local_parking_outlined,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Parking",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: pageIndex == 1
                      ? const Icon(
                          Icons.car_crash,
                          size: 35,
                        )
                      : Icon(
                          Icons.car_crash_outlined,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Request",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: pageIndex == 2
                      ? const Icon(
                          Icons.person,
                          size: 35,
                        )
                      : Icon(
                          Icons.person_outline,
                          size: 35,
                          color: TColor.secondary,
                        ),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
