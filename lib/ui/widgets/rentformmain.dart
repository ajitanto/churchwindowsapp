
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/sidemenuaccform.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/rentFormList.dart';
import 'package:church_windows/ui/widgets/rentuserdet.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:church_windows/ui/widgets/sidemenuacc.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RentFormMain extends StatefulWidget {
final String? userid;
final String? formtype;
final String? yearcycle;
  const RentFormMain({Key? key,this.userid,this.formtype,this.yearcycle}) : super(key: key);

  @override
  State<RentFormMain> createState() => _RentFormMainState();
}

class _RentFormMainState extends State<RentFormMain> {

  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          drawer:  SideMenuaccform(widget.userid.toString(),widget.yearcycle.toString()),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                 Expanded(
                  child: SideMenuaccform(widget.userid.toString(),widget.yearcycle.toString()),
                ),
              horizontalSpaceRegular,
               Expanded(
                flex: 4,
              
               
                  child:RentFormList(userid:widget.userid,formtype: widget.formtype,yearcycle: widget.yearcycle),
            
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
