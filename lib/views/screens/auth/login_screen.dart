import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutr/common/constants/app_colors.dart';
import 'package:tutr/common/constants/text_styles.dart';
import 'package:tutr/common/widgets/custom_appbar.dart';
import 'package:tutr/common/widgets/custom_button.dart';
import 'package:tutr/common/widgets/custom_loading_widget.dart';
import 'package:tutr/common/widgets/custom_textfield.dart';
import 'package:tutr/common/widgets/gaps.dart';
import 'package:tutr/features/auth/controller/auth_controller.dart';
import 'package:tutr/features/auth/controller/auth_states.dart';
import 'package:tutr/helpers/extensions.dart';
import 'package:tutr/models/route_arguments/auth_arguments.dart';
import 'package:tutr/routes/route_names.dart';
import 'package:tutr/views/widgets/auth_widgets/email_otp_widget.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    super.key,
    required this.authType,
  });
  final UserAuthType authType;

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
                "You are a  ${authType.authType.capitalizeFirst()}. . . .",
                style: GoogleFonts.lato(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                "Enter your email to login as ${authType.authType.capitalizeFirst()}",
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
                text: TextSpan(
                    text: "Don't have an Account? ",
                    style: GoogleFonts.lato(color: AppColors.textColor1),
                    children: [
                      TextSpan(
                        text: " Create Account",
                        style: GoogleFonts.lato(color: AppColors.textButtonTextColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            providerFunc.getAllTeachersList();
                            Navigator.pushNamed(context, RouteNames.registerStudent, arguments: authType);
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
                  // providerFunc.changeActiveStep(1);
                  providerFunc.sendEmailOTP();

                  // CustomSnackbar.show(
                  //   context: context,
                  //   message: providerFunc.emailController.text,
                  // );
                },
                label: authStates.sendOTPLoading
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
