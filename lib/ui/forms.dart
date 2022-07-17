

// ignore_for_ prefer_const_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: avoid_print

import 'package:church_windows/modal/demo.dart';
import 'package:church_windows/modal/formmodal.dart';
import 'package:church_windows/services/editword.dart';
import 'package:church_windows/ui/widgets/banns.dart';
import 'package:church_windows/ui/widgets/baptism.dart';
import 'package:church_windows/ui/widgets/main_header.dart';
import 'package:church_windows/ui/widgets/marriage.dart';
import 'package:church_windows/ui/widgets/marriage3.dart';
import 'package:church_windows/ui/widgets/marriage4.dart';
import 'package:church_windows/ui/widgets/marriage5.dart';
import 'package:church_windows/ui/widgets/marriage6.dart';
import 'package:church_windows/ui/widgets/marriage7.dart';
import 'package:church_windows/ui/widgets/marriage8.dart';


import 'package:intl/intl.dart';

import 'package:responsive_context/responsive_context.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';


import 'package:church_windows/ui/shared/spacing.dart';

import 'package:flutter/material.dart';


class FormList extends StatefulWidget {
final String? formtype;
   FormList({Key? key,this.formtype}) : super(key: key);

  @override
  State<FormList> createState() => _FormListState();
}

class _FormListState extends State<FormList> {
 
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
   (widget.formtype=="Baptism")?BaptismForm():(widget.formtype=="Banns")?BannsForm():(widget.formtype=="Marriage")?MarriageForm():(widget.formtype=="Marriage3")?MarriageForm3():(widget.formtype=="Marriage4")?MarriageForm4():(widget.formtype=="Marriage5")?MarriageForm5():(widget.formtype=="Marriage6")?MarriageForm6():(widget.formtype=="Marriage7")?MarriageForm7():(widget.formtype=="Marriage8")?MarriageForm8():SizedBox(),
       verticalSpaceRegular,
            
        ],
         )
         )
       ]
       ) );
      
  }
 
}
