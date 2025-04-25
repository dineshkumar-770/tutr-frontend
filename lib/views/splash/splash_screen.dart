import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lottie/lottie.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showButtons = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await navigateToRootScreen(context);
        await showButtonsNow();
      },
    );
    super.initState();
  }

  Future<void> showButtonsNow() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      showButtons = true;
    });
  }

  Future<void> navigateToRootScreen(BuildContext ctx) async {
    if (Prefs.getString(ConstantStrings.userToken).isNotEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      if (ctx.mounted) {
        Navigator.pushReplacementNamed(ctx, AppRouteNames.rootScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset(
                    "assets/lotties/welcome.json",
                  )),
              Text(
                "Welcome To TUTR",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textColor1, fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text(
                  "Find. Learn. Grow. Succeed. 🚀",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textColor1, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              if (showButtons) ...[
                Spacer(),
                Text(
                  " Continue As",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textColor1, fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                child: showButtons
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRouteNames.loginScreen,
                                    arguments: ConstantStrings.teacher);
                              },
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryButtonColor)),
                              label: Text(
                                "Teacher",
                                style: TextStyle(color: AppColors.buttonTextColor, fontSize: 16),
                              ),
                              icon: Icon(
                                FontAwesomeIcons.person,
                                color: AppColors.buttonTextColor,
                                size: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRouteNames.loginScreen,
                                    arguments: ConstantStrings.student);
                              },
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryButtonColor)),
                              label: Text(
                                "Student",
                                style: TextStyle(color: AppColors.buttonTextColor, fontSize: 16),
                              ),
                              icon: Icon(
                                FontAwesomeIcons.peopleLine,
                                color: AppColors.buttonTextColor,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
