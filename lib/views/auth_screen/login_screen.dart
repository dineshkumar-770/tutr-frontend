// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/viewmodels/auth_bloc/bloc/auth_bloc.dart';
import 'package:tutr_frontend/widgets/auth_widgets/otp_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.userType,
  });
  final String userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  if (state.activeStep == 0) ...[
                    Text(
                      "Logging in as ${widget.userType},",
                      style: TextStyle(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Enter your email to login as ${widget.userType}",
                      style: TextStyle(color: AppColors.textColor1, fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    Gaps.verticalGap(value: 20),
                    Center(
                      child: CustomTextField(
                        label: "Email",
                        hint: "Enter your email",
                        controller: emailController,
                      ),
                    ),
                    Gaps.verticalGap(value: 5),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an Account? ",
                          style: TextStyle(color: AppColors.textColor1, fontSize: 16),
                          children: [
                            TextSpan(
                              text: " Create Account",
                              style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<AuthBloc>().add(RegisterUserCollectInfoEvent(
                                      selectedClass: state.selectedClass,
                                      selectedClasses: [],
                                      userType: widget.userType));
                                  Navigator.pushNamed(context, AppRouteNames.registerScreen,
                                      arguments: widget.userType);
                                },
                            )
                          ]),
                    ),
                    Gaps.verticalGap(value: 50),
                    TutrPrimaryButton(
                      label: state.sendOTPLoading ? "Sending OTP..." : "Login",
                      onPressed: () {
                        final RegExp emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (emailController.text.isEmpty) {
                          CustomToast.show(
                              toastType: ToastificationType.warning,
                              context: context,
                              title: "Email is required to continue.");
                        } else if (!emailRegex.hasMatch(emailController.text)) {
                          CustomToast.show(
                              toastType: ToastificationType.warning,
                              context: context,
                              title: "Incorrect email provided. Kindly recheck the email");
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(SendOTPEvent(activeStep: 1, email: emailController.text, userType: widget.userType));
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: AppColors.buttonTextColor,
                        size: 22,
                      ),
                    )
                  ] else if (state.activeStep == 1) ...[
                    OtpWidget(
                      otpController: otpController,
                      onTapReEnterEmail: () {},
                      email: emailController.text,
                      loginType: widget.userType,
                    )
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
