
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          drawer:  SideMenu(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
               Expanded(
                  child: SideMenu(),
                ),
              horizontalSpaceRegular,
               Expanded(
                flex: 4,
              
                child: Center(
                  child:DashBoardView(),
                ),
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
