import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:peeker/utils/assets_manager.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/const.dart';
import 'package:peeker/utils/layout.dart';
import 'package:peeker/utils/route_manager.dart';
import 'package:peeker/utils/validator.dart';
import 'package:peeker/views/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  void toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Layout.getScreenHeight(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets.authBg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Layout.getWidth(20),
                vertical: Layout.getHeight(20),
              ),
              child: Column(
                children: [
                  Gap(150),
                  Container(
                    child: Text(
                      'Welcome Back To Peeker',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              controller: _emailTextEditingController,
                              cursorColor: ColorManager.secondaryColor,
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: ColorManager.secondaryColor,
                                ),
                              ),
                              validator: (val) => validateEmail(val!),
                              onSaved: (value) {
                                _emailTextEditingController.text;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Gap(15),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              controller: _passwordTextEditingController,
                              cursorColor: ColorManager.secondaryColor,
                              keyboardType: TextInputType.text,
                              enableSuggestions: true,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: ColorManager.secondaryColor,
                                ),
                                suffixIcon: IconButton(
                                  color: ColorManager.secondaryColor,
                                  onPressed: toggleObscureText,
                                  icon: _obscureText
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                              validator: (val) => validatePassword(val!),
                              onSaved: (value) {
                                _passwordTextEditingController.text;
                              },
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  CustomButton(() {
                    authController.loginUser(_emailTextEditingController.text,
                        _passwordTextEditingController.text);
                  }, 'Login'),
                  Divider(
                    height: 1,
                    color: ColorManager.grey,
                    thickness: 0.3,
                  ),
                  Gap(Layout.getHeight(15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorManager.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signup);
                        },
                        child: Text(
                          ' Signup',
                          style: TextStyle(
                            color: ColorManager.secondaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
