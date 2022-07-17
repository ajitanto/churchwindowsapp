
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/rentallist.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/widgets/dashboard_view.dart';
import 'package:church_windows/ui/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class Rentledger extends StatefulWidget {
  const Rentledger({Key? key}) : super(key: key);

  @override
  State<Rentledger> createState() => _RentledgerState();
}

class _RentledgerState extends State<Rentledger> {
String yearcycle="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime now = DateTime.now();

String monthnow=DateFormat.M().format(now);
String yearnow=DateFormat.y().format(now);
if(int.parse(monthnow)>=4){
  setState(() {
    yearcycle=int.parse(yearnow).toString()+"-"+(int.parse(yearnow)+1).toString();
  });

}
else if(int.parse(monthnow)<=3){
  setState(() {
      yearcycle=(int.parse(yearnow)-1).toString()+"-."+int.parse(yearnow).toString();
  });

}
  }
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
              
               
                  child:Rentallist(yearcycle: yearcycle),
            
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
