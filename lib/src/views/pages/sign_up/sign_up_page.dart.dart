import 'package:catatan_sehat_ku/services/auth_service.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_link_text.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpHandler() async {
    try {
      await AuthService().signUp(
        email: emailController.text,
        password: passwordController.text,
        displayName: namaController.text,
      );

      Fluttertoast.showToast(
        msg: "Successfully sign up in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      App.to("/home");
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to Sign Up",
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
                        'Sign Up',
                        style: App.text.headlineSmall!.copyWith(color: App.color.primary),
                      ),
                      const SizedBox(height: 25),
                      AppTextField(
                        controller: namaController,
                        hintText: "Nama",
                        prefixIcon: Icon(
                          Icons.person_2_rounded,
                          size: 18.sp,
                          color: App.color.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      ),
                      const SizedBox(height: 50),
                      AppButton(
                        onTap: signUpHandler,
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(color: App.color.onPrimary),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppLinkText(
                            onTap: App.back,
                            text: "Already Have an Account",
                          ),
                        ],
                      ),
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
