import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tutr/features/groups_and_manage/views/home_screen.dart';
import 'package:tutr/features/root_page/view/welcome_screen.dart';
import 'package:tutr/resources/app_colors.dart';
import 'package:tutr/resources/constant_strings.dart';
import 'package:tutr/utils/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigateToScreen(BuildContext context) async {
    final token = Prefs.getString(ConstantStrings.tokenKey);
    await Future.delayed(const Duration(seconds: 3));
    if (token.isEmpty) {
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ));
      }
    } else {
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await navigateToScreen(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset("assets/lotties/welcome.json", animate: false)),
          Text(
            "Welcome to TuTr",
            style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
