import 'package:duffldigitaltask/core/widgets/font_style.dart';
import 'package:duffldigitaltask/homescreen.dart';
import 'package:duffldigitaltask/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final phoneNumberControlller = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Center(
            child: const Text("Success", textAlign: TextAlign.center),
          ),
          content: const Text(
            "Yor Are Login Successfully.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/background.png", fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Connecting Talents and Clients Effortlessly",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Login to continue",
                      style: AppTextStyles.loginText,
                    ),

                    const SizedBox(height: 25),

                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: phoneNumberControlller,
                            hint: "Mobile Number",
                            validator: Validators.validatePhone,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            prefix: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 8,
                              ),
                              child: Text(
                                "+91",
                                style: AppTextStyles.textField.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          CustomTextField(
                            controller: passwordController,
                            hint: "Password",
                            validator: Validators.validatePassword,
                            obscure: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: vm.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) return;

                                bool ok = await vm.login(
                                  phoneNumberControlller.text.trim(),
                                  passwordController.text.trim(),
                                );

                                // if (ok) showSuccessDialog(context);
                                if (ok) {
                                  showSuccessDialog(context).then((_) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginScreen(),
                                      ),
                                    );
                                  });
                                }
                              },
                        child: vm.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {},
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don’t have an account? ",
                              style: AppTextStyles.textField.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: "Sign up",
                              style: AppTextStyles.heading.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "By continuing, you agree to our Terms of Service & Privacy Policy",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textField.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
