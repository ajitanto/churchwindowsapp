
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_field

import 'package:church_windows/responsive.dart';
import 'package:church_windows/services/editword.dart';
import 'package:church_windows/ui/createcertificate.dart';
import 'package:church_windows/ui/forms.dart';
import 'package:church_windows/ui/rentledger.dart';
import 'package:church_windows/ui/shared/colors.dart';
import 'package:church_windows/ui/shared/edge_insect.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/shared/text_styles.dart';
import 'package:church_windows/ui/widgets/main_header.dart';
import 'package:flutter/material.dart';

class CertiDashBoardView extends StatefulWidget {

  CertiDashBoardView();

  @override
  CertiDashBoardViewState createState() => CertiDashBoardViewState();
}

class CertiDashBoardViewState extends State<CertiDashBoardView> {
  @override

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Size _size = MediaQuery.of(context).size;

    return CustomScrollView(
      controller: ScrollController(),
       shrinkWrap: true,
       slivers: <Widget>[
         SliverList(delegate: SliverChildListDelegate(
    [
     
              verticalSpaceSmall,
           MainHeader(),
              verticalSpaceRegular,
              Container(child:Column(children: [

      
              Container(
                padding: kEdgeInsetsHorizontalNormal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBlackColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Certificates',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage',
                          style: kHeading1TextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                             Container(
                      padding: kEdgeInsetsHorizontalNormal,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kWhiteColor),
                      child: Center(
                        child:GestureDetector(
                          onTap: (){
                            // createcerti(context);
                           Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CertiPage(formtype: "Marriage",menutype: "Certificates")),
                                          );
                          },
                        child: Text(
                          'Create',
                          style: kBodyTextStyle.copyWith(color: kBlackColor),
                        ),
                        ),
                      ),
                    ),
            
                  ],
                ),
                height: height * 0.20,
              ),
              verticalSpaceRegular,
              Container(
                padding: kEdgeInsetsHorizontalNormal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBlackColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Certificates',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Baptism',
                          style: kHeading1TextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                             Container(
                      padding: kEdgeInsetsHorizontalNormal,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kWhiteColor),
                      child: Center(
                        child:GestureDetector(
                          onTap: (){
                            // createcerti(context);
                           Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CertiPage(formtype: "Baptism",menutype: "Certificates")),
                                          );
                          },
                        child: Text(
                          'Create',
                          style: kBodyTextStyle.copyWith(color: kBlackColor),
                        ),
                        ),
                      ),
                    ),
            
                  ],
                ),
                height: height * 0.20,
              ),
        
              ],)),
         
           
    
      ],
         )
         )
       ]
    );
  }
}
