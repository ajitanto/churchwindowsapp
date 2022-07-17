
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

class FormDashBoardView extends StatefulWidget {

  FormDashBoardView();

  @override
  FormDashBoardViewState createState() => FormDashBoardViewState();
}

class FormDashBoardViewState extends State<FormDashBoardView> {
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Banns ( before Betrothal )',
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
                                                    CertiPage(formtype: "Banns",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 3',
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
                                                    CertiPage(formtype: "Marriage3",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 4',
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
                                                    CertiPage(formtype: "Marriage4",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 5',
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
                                                    CertiPage(formtype: "Marriage5",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 6',
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
                                                    CertiPage(formtype: "Marriage6",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 7',
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
                                                    CertiPage(formtype: "Marriage7",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
                          'Forms',
                          style: kBodyRegularTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          'Marriage Form 8',
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
                                                    CertiPage(formtype: "Marriage8",menutype: "Forms")),
                                          );
                          },
                        child: Text(
                          'View',
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
