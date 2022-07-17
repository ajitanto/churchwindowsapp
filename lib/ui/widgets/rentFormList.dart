

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print

import 'package:church_windows/modal/demo.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/modal/rentmonth.dart';
import 'package:church_windows/services/editword.dart';
import 'package:church_windows/ui/widgets/add_rentform.dart';
import 'package:church_windows/ui/widgets/banns.dart';
import 'package:church_windows/ui/widgets/baptism.dart';
import 'package:church_windows/ui/widgets/deactivateuser.dart';
import 'package:church_windows/ui/widgets/editrentuserdet.dart';
import 'package:church_windows/ui/widgets/main_header.dart';
import 'package:church_windows/ui/widgets/marriage.dart';
import 'package:church_windows/ui/widgets/marriage3.dart';
import 'package:church_windows/ui/widgets/marriage4.dart';
import 'package:church_windows/ui/widgets/marriage5.dart';
import 'package:church_windows/ui/widgets/marriage6.dart';
import 'package:church_windows/ui/widgets/marriage7.dart';
import 'package:church_windows/ui/widgets/marriage8.dart';
import 'package:church_windows/ui/widgets/updaterentform.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';


class RentFormList extends StatefulWidget {
final String? formtype;
final String? userid;
final String? yearcycle;
   RentFormList({Key? key,this.userid,this.formtype,this.yearcycle}) : super(key: key);

  @override
  State<RentFormList> createState() => _RentFormListState();
}

class _RentFormListState extends State<RentFormList> {
 
  @override
 void initState() {
   super.initState();

 }
 
  @override
  Widget build(BuildContext context) {


 
    final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

      return Scaffold(
      body:CustomScrollView(
      controller: ScrollController(),
       shrinkWrap: true,
       slivers: <Widget>[
         SliverList(delegate: SliverChildListDelegate(
    [
      verticalSpaceSmall,
           MainHeader(),
          
       
         verticalSpaceRegular,
   (widget.formtype=="Addrent")?AddrentForm(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):(widget.formtype=="editrentuser")?EditRentForm(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):(widget.formtype=="Addrent")?AddrentForm(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):(widget.formtype=="updaterentform")?Updaterentuser(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):(widget.formtype=="Addrent")?AddrentForm(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):(widget.formtype=="deactivateuser")?DeactiveUser(userid: widget.userid, formtype: widget.formtype,yearcycle: widget.yearcycle):SizedBox(),
       verticalSpaceRegular,
            
        ],
         )
         )
       ]
       ) );
      
  }
 
}
