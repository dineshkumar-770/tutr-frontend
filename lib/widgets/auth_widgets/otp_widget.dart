// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/utils/custom_extensions.dart';
import 'package:tutr_frontend/viewmodels/auth_bloc/bloc/auth_bloc.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.otpController,
    this.onTapReEnterEmail,
    required this.loginType,
    required this.email,
  });
  final TextEditingController otpController;
  final void Function()? onTapReEnterEmail;
  final String loginType;
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the OTP sent over your mail",
              style: TextStyle(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w600),
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
            RichText(
              text: TextSpan(text: "Couldn't receive OTP? ", style: TextStyle(color: AppColors.textColor1), children: [
                TextSpan(
                  text: " Resend OTP\n",
                  style: TextStyle(color: AppColors.textButtonTextColor, fontSize: 16),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: " \nProvided Incorrect email? ",
                  style: TextStyle(color: AppColors.textColor1),
                ),
                TextSpan(
                  text: " Re-enter Email? ",
                  style: TextStyle(color: AppColors.textButtonTextColor, fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<AuthBloc>().add(ActiveStepEvent(activeStep: 0));
                    },
                ),
              ]),
            ),
            Gaps.verticalGap(value: 50),
            
            TutrPrimaryButton(
              label: state.verifyOTPLoading ? "Verifying..." : "Verify",
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(VerifyOTPEvent(otp: otpController.text, email: email, loginType: loginType));
              },
            )
          ],
        );
      },
    );
  }
}
