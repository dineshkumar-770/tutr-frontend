import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutr/common/custom_appbar.dart';
import 'package:tutr/common/custom_button.dart';
import 'package:tutr/common/custom_loading_widget.dart';
import 'package:tutr/common/custom_message_widget.dart';
import 'package:tutr/common/custom_textfield.dart';
import 'package:tutr/features/auth/controller/auth_controller.dart';
import 'package:tutr/features/auth/controller/auth_states.dart';
import 'package:tutr/features/auth/views/register_screen.dart';
import 'package:tutr/features/auth/widgets/email_otp_widget.dart';
import 'package:tutr/helpers/extensions.dart';
import 'package:tutr/helpers/gaps.dart';
import 'package:tutr/resources/app_colors.dart';
import 'package:tutr/resources/text_styles.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    super.key,
    required this.loginType,
  });
  final String loginType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthStates authStates = ref.watch(authNotifierProvider);
    final providerFunc = ref.read(authNotifierProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "TuTr"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (authStates.loginActiveStep == 0) ...[
              Text(
                "You are a  ${loginType.capitalizeFirst()}. . . .",
                style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                "Enter your email to login as ${loginType.capitalizeFirst()}",
                style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Gaps.verticalGap(value: 20),
              CustomTextField(
                label: "Email",
                hint: "Enter your email",
                controller: providerFunc.emailController,
                textInputType: TextInputType.emailAddress,
              ),
              Gaps.verticalGap(value: 10),
              RichText(
                text: TextSpan(text: "Don't have an Account? ", style: GoogleFonts.lato(color: AppColors.textColor1), children: [
                  TextSpan(
                    text: " Create Account",
                    style: GoogleFonts.lato(color: AppColors.textButtonTextColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        providerFunc.getAllTeachersList();
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => RegisterScreen(
                                registerType: loginType,
                              ),
                            ));
                      },
                  )
                ]),
              ),
            ] else if (authStates.loginActiveStep == 1) ...[
              EmailOtpWidget(
                otpController: providerFunc.emailOTPController,
              )
            ] else ...[
              const SizedBox.shrink()
            ],
            Spacer(),
            CustomButton(
                onTap: () {
                  switch (authStates.loginActiveStep) {
                    case 0:
                      if (providerFunc.emailController.text.isEmpty) {
                        CustomSnackbar.show(context: context, message: "Email is Required!", isSuccess: false);
                      } else {
                        providerFunc.sendEmailOTP(
                            loginType: loginType, email: providerFunc.emailController.text, context: context);
                      }
                      break;
                    case 1:
                      providerFunc.verifyEmailOTP(
                          context: context,
                          email: providerFunc.emailController.text,
                          loginType: loginType,
                          otp: providerFunc.emailOTPController.text);
                      break;
                    default:
                  }
                },
                label: (authStates.sendOTPLoading || authStates.verifyOTPLoading)
                    ? CustomLoadingWidget()
                    : Text(
                        authStates.loginActiveStep == 1 ? "Verify" : "Login",
                        style: CustomTextStylesAndDecorations.primaryButtonTextStyle(),
                      ))
          ],
        ),
      ),
    );
  }
}
