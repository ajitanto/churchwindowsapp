
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/certidashboard.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:church_windows/ui/widgets/sidemenusub.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Maincertificates extends StatefulWidget {
  const Maincertificates({Key? key}) : super(key: key);

  @override
  State<Maincertificates> createState() => _MaincertificatesState();
}

class _MaincertificatesState extends State<Maincertificates> {

  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          drawer:  SideMenusub("Certificates"),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                 Expanded(
                  child: SideMenusub("Certificates"),
                ),
              horizontalSpaceRegular,
            Expanded(
                flex: 4,
              
               
                  child:Center(child: CertiDashBoardView()),
            
              ),
              horizontalSpaceSmall,
            ],
          ),
        );
      },
         viewModelBuilder: () => MainViewModel(),
    );
  }
}
