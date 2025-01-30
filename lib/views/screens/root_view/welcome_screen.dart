import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tutr/common/constants/app_colors.dart';
import 'package:tutr/common/constants/constant_strings.dart';
import 'package:tutr/common/constants/text_styles.dart';
import 'package:tutr/common/widgets/custom_button.dart';
import 'package:tutr/models/route_arguments/auth_arguments.dart';
import 'package:tutr/routes/route_names.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  "assets/lotties/welcome.json",
                )),
            Text(
              "Welcome to TuTr",
              style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            CustomButton(
              label: Text(
                "Continue as Teacher",
                style: CustomTextStylesAndDecorations.primaryButtonTextStyle(),
              ),
              height: 50,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.loginTeacher,
                    arguments: UserAuthType(authType: ConstantStrings.teacher));
              },
            ),
            CustomButton(
              label: Text(
                "Continue as Student",
                style: CustomTextStylesAndDecorations.primaryButtonTextStyle(),
              ),
              height: 50,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.loginStudent,
                    arguments: UserAuthType(authType: ConstantStrings.student));
              },
            )
          ],
        ),
      ),
    );
  }
}
