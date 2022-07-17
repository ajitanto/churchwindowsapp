
import 'package:church_windows/main.dart';
import 'package:church_windows/main/certificate_main.dart';
import 'package:church_windows/main/form_main.dart';
import 'package:church_windows/ui/shared/colors.dart';
import 'package:church_windows/ui/shared/text_styles.dart';
import 'package:flutter/material.dart';
class SideMenusub extends StatefulWidget {
  final String applicationtype;
  SideMenusub(this.applicationtype);

  @override
  SideMenusubState createState() => SideMenusubState();
}

class SideMenusubState extends State<SideMenusub> {

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
            title: "Home",
            icon: Icons.home,
            press: () {
                           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyApp()),
  );
            },
          ),
          (widget.applicationtype=="Certificates")? Container(
            color: Colors.grey,
            child:DrawerListTile(
            title: "Certificates",
            
           icon: Icons.document_scanner,

            press: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Maincertificates()),
  );
    
            },
          )):DrawerListTile(
            title: "Certificates",
            
            icon: Icons.document_scanner,

            press: () {

                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Maincertificates()),
  );
            },
          ),

            (widget.applicationtype=="Forms")? Container(
            color: Colors.grey,
            child:DrawerListTile(
            title: "Forms",
            
           icon: Icons.document_scanner,

            press: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Mainform()),
  );
    
            },
          )):DrawerListTile(
            title: "Forms",
            
            icon: Icons.document_scanner,

            press: () {

                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Mainform()),
  );
            },
          ),
            
          DrawerListTile(
            title: "Accounting",
            icon: Icons.transform,
            press: () {},
          ),
         
    
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
