
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/rentuserdet.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:church_windows/ui/widgets/sidemenuacc.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RentLedgerUser extends StatefulWidget {
final String? userid;
final String? yearcycle;
  const RentLedgerUser({Key? key,this.userid,this.yearcycle}) : super(key: key);

  @override
  State<RentLedgerUser> createState() => _RentLedgerUserState();
}

class _RentLedgerUserState extends State<RentLedgerUser> {

  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          drawer:  SideMenuacc(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                 Expanded(
                  child: SideMenuacc(),
                ),
              horizontalSpaceRegular,
               Expanded(
                flex: 4,
              
               
                  child:Rentaluserdet(userid:widget.userid,yearcycle: widget.yearcycle),
            
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
