
import 'package:church_windows/main/main_viewmodel.dart';
import 'package:church_windows/responsive.dart';
import 'package:church_windows/ui/shared/colors.dart';
import 'package:church_windows/ui/shared/spacing.dart';
import 'package:church_windows/ui/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainHeader extends ViewModelWidget<MainViewModel> {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, viewModel) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: kBlackColor,
            ),
            onPressed: viewModel.controlMenu,
          ),
        horizontalSpaceSmall,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
         
            Text(
              'Welcome back,',
              style: kBodyRegularTextStyle,
            ),
            Text(
              'Admin',
              style: kHeading3TextStyle,
            ),
          ],
        ),
        const Spacer(),
        
      ],
    );
  }
}
