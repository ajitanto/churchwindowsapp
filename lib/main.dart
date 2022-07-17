
// import 'package:church_windows/main/main_view.dart';
// import 'package:church_windows/ui/shared/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Immaculate Conception',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: kWhiteColor,
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
//             .apply(bodyColor: Colors.white),
//         canvasColor: kSecondaryColor2,
//       ),
//       home: const MainView(),
//     );
//   }
// }



import 'package:church_windows/main/main_view.dart';
import 'package:flutter/material.dart';

import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
    
          BouncingScrollWrapper.builder(context, widget!),
          
          maxWidth: 2000,
          minWidth: 2000,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          
          background: Container(color: const Color(0xFFF5F5F5))),
  initialRoute: "/",
  home: MainView(),
      
    );
  }
}