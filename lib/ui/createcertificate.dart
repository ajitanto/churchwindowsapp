
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/forms.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:church_windows/ui/widgets/sidemenusub.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CertiPage extends StatefulWidget {
  final String? formtype;
  final String? menutype;
  const CertiPage({Key? key,this.formtype,this.menutype}) : super(key: key);

  @override
  State<CertiPage> createState() => _CertiPageState();
}

class _CertiPageState extends State<CertiPage> {

  
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
                  child: SideMenusub(widget.menutype.toString()),
                ),
              horizontalSpaceRegular,
                Expanded(
                flex: 4,
              
               
                  child:FormList(formtype: widget.formtype),
            
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
