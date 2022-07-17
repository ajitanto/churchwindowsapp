
import 'package:church_windows/main.dart';
import 'package:church_windows/main/certificate_main.dart';
import 'package:church_windows/main/form_main.dart';
import 'package:church_windows/ui/rentledger.dart';
import 'package:church_windows/ui/shared/colors.dart';
import 'package:church_windows/ui/shared/text_styles.dart';
import 'package:flutter/material.dart';
class SideMenuacc extends StatefulWidget {
  SideMenuacc();

  @override
  SideMenuaccState createState() => SideMenuaccState();
}

class SideMenuaccState extends State<SideMenuacc> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kTertiaryColor5,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                const Icon(
                  Icons.add_box,
                  color: kBlackColor,
                ),
                Expanded(
                  child: Text(
                    'Immaculate Conception Church',
                    style: kHeading3TextStyle,
                  ),
                )
              ],
            ),
          ),
                 DrawerListTile(
            title: "Back",
            icon: Icons.arrow_back,
            press: () {
   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Rentledger()),
  );
                 }),     DrawerListTile(
            title: "Home",
            icon: Icons.home,
            press: () {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyApp()),
  );
            },
          ),
          DrawerListTile(
            title: "Certificates",
            icon: Icons.card_giftcard,
            press: () {
                          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Maincertificates()),
  );
            },
          ),
            DrawerListTile(
            title: "Forms",
            icon: Icons.card_giftcard,
            press: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Mainform()),
  );
            },
          ),
          DrawerListTile(
            title: "Rent (Accounting)",
            icon: Icons.transform,
            press: () {
                  MaterialPageRoute(builder: (context) =>  Rentledger());
            },
          ),
         
          // DrawerListTile(
          //   title: "Settings",
          //   icon: Icons.settings,
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Logout",
          //   icon: Icons.logout,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: kBlackColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: kBlackColor),
      ),
    );
  }
}
