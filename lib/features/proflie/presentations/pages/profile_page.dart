import 'package:flutter/material.dart';
import 'package:mawqifi_driver/common/globs.dart';
import 'package:mawqifi_driver/common_widget/profile_action_item.dart';
import 'package:mawqifi_driver/features/auth/mobile_login/presentations/page/mobile_number_page.dart';
import 'package:mawqifi_driver/features/proflie/presentations/pages/create_profile_page.dart';
import 'package:mawqifi_driver/features/vehicle/presentations/pages/vehicle_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Account Info",
          icon: Icons.account_circle,
          onTap: () {
            Navigator.push(context, CreateProfilePage.route(Globs.udValueString(PreferenceKey.phoneNumber),true));
          },
        ),
        const SizedBox(
          height: 26,
        ),
        /*ProfileActionItem(
          title: "My Vehicles",
          icon: Icons.drive_eta,
          onTap: () {
            Navigator.push(context, VehicleList.route());
          },
        ),
        const SizedBox(
          height: 26,
        ),*/
        /*ProfileActionItem(
          title: "Payments",
          icon: Icons.payments,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Refer & Earn",
          icon: Icons.card_giftcard,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),*/
        ProfileActionItem(
          title: "Help",
          icon: Icons.help,
          onTap: () {},
        ),
        const SizedBox(
          height: 26,
        ),
        ProfileActionItem(
          title: "Logout",
          icon: Icons.logout,
          onTap: () {
            Globs.udClearAllKey()?.then(
              (value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MobileNumberPage.route(),
                    (route) => false,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
