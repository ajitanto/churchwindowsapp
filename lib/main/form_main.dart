
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/certidashboard.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/formdashboard.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:church_windows/ui/widgets/sidemenusub.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Mainform extends StatefulWidget {
  const Mainform({Key? key}) : super(key: key);

  @override
  State<Mainform> createState() => _MainformState();
}

class _MainformState extends State<Mainform> {

  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          drawer:  SideMenusub("Forms"),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                 Expanded(
                  child: SideMenusub("Forms"),
                ),
              horizontalSpaceRegular,
            Expanded(
                flex: 4,
              
               
                  child:Center(child: FormDashBoardView()),
            
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
