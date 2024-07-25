import 'package:catatan_sehat_ku/services/auth_service.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/auth_cubit.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_link_text.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> signInHandler() async {
    try {
      await AuthService().signIn(email: emailController.text, password: passwordController.text);

      App.to("/home");
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to Sign In",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: 100.sw,
            height: 100.sh,
            child: Image.asset(
              "assets/background.webp",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 0.35.sh),
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 15, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: App.color.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Catatan Sehat ku',
                        style: App.text.headlineMedium!.copyWith(color: App.color.primary),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sign In',
                        style: App.text.headlineSmall!.copyWith(color: App.color.primary),
                      ),
                      const SizedBox(height: 25),
                      const SizedBox(),
                      AppTextField(
                        controller: emailController,
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.alternate_email_rounded,
                          size: 18.sp,
                          color: App.color.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        controller: passwordController,
                        hintText: "Password",
                        isSecret: true,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          size: 18.sp,
                          color: App.color.primary,
                        ),
                        suffixIcon: Icon(
                          color: App.color.onSurface,
                          Icons.visibility_rounded,
                          size: 18.sp,
                        ),
                      ),
                      const SizedBox(height: 50),
                      AppButton(
                        onTap: () async => await signInHandler(),
                        child: Text(
                          'SIGN IN',
                          style: App.text.bodyMedium!.copyWith(color: App.color.onPrimary),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppLinkText(
                            onTap: () => App.to("/signup"),
                            text: "Create Account",
                          ),
                          // AppLinkText(
                          //   onTap: () => {},
                          //   text: "Forgot Password",
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
