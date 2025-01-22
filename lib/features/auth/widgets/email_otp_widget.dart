import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:tutr/features/auth/controller/auth_controller.dart';
import 'package:tutr/helpers/extensions.dart';
import 'package:tutr/helpers/gaps.dart';
import 'package:tutr/resources/app_colors.dart';

class EmailOtpWidget extends StatelessWidget {
  const EmailOtpWidget({super.key, required this.otpController});
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter the OTP sent over your mail",
          style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        Gaps.verticalGap(value: 20),
        Text(
          "OTP",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontFamily: 'InterTight',
                fontSize: 12,
              ),
        ),
        Gaps.verticalGap(value: 5),
        Pinput(
            controller: otpController,
            closeKeyboardWhenCompleted: true,
            length: 6,
            keyboardType: TextInputType.text,
            autofocus: true,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            isCursorAnimationEnabled: true,
            inputFormatters: [UpperCaseTextFormatter()],
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: TextStyle(fontSize: 24, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
            )),
        Gaps.verticalGap(value: 15),
        Consumer(builder: (context, ref01, _) {
          return RichText(
            text: TextSpan(
                text: "Couldn't receive OTP? ",
                style: GoogleFonts.lato(color: AppColors.textColor1),
                children: [
                  TextSpan(
                    text: " Resend OTP\n",
                    style: GoogleFonts.lato(color: AppColors.textButtonTextColor, fontSize: 16),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: " \nProvided Incorrect email? ",
                    style: GoogleFonts.lato(color: AppColors.textColor1),
                  ),
                  TextSpan(
                    text: " Re-enter Email? ",
                    style: GoogleFonts.lato(color: AppColors.textButtonTextColor, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ref01.read(authNotifierProvider.notifier).changeActiveStep(0);
                        ref01.read(authNotifierProvider.notifier).emailOTPController.clear();
                      },
                  ),
                ]),
          );
        }),
      ],
    );
  }
}
