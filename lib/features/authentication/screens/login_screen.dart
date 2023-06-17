import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_project_sat26/features/authentication/screens/register_screen.dart';
import 'package:new_project_sat26/features/home/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/prefs_key_constants.dart';
import '../widgets/custom_text_field.dart';

// assets
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading
            ? Center(
              child: Lottie.asset(
                  'assets/loading.json',
                  height: 80,
                  width: 80,
                ),
            )
            : Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // image jpg / jpeg / png
                    Image.asset(
                      'assets/images/logo.png',
                      height: 72,
                      width: 72,
                    ),

                    SizedBox(height: 10),
                    // welcome text
                    Text(
                      'Welcome to Lafyuu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff223263),
                      ),
                    ),

                    SizedBox(height: 8),

                    // sign in text
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9098B1),
                      ),
                    ),

                    // text field email
                    CustomTextField(
                      hint: 'Your Email',
                      controller: emailController,
                      icon: Icons.email_outlined,
                      validation: (text) {
                        if (!text!.contains('@')) {
                          return 'Email not correct!';
                        }

                        return null;
                      },
                    ),

                    // text field password
                    CustomTextField(
                      controller: passwordController,
                      hint: 'Your Password',
                      icon: Icons.lock_outline,
                      obscureText: isObscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                        icon: isObscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      validation: (text) {
                        if (text!.length < 5) {
                          return 'Password should be more than or equal 6 characters';
                        }

                        return null;
                      },
                    ),

                    // sign in button
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: _loginMethod,
                        // onPressed: () => _loginMethod(),
                        // onPressed: () { _loginMethod(); },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: passwordController.text.isEmpty
                              ? Colors.grey
                              : Color(0xff40BFFF),
                          shadowColor: Color(0xff40BFFF).withOpacity(0.24),
                          // fixedSize: Size(MediaQuery.of(context).size.width * 0.5, 40),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    // or text
                    // Divider(
                    //   color: Colors.grey,
                    //   height: 1,
                    //   thickness: 3,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          width: 200,
                          color: Colors.grey,
                        ),
                        Text('OR'),
                        Container(
                          height: 1,
                          width: 200,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    // login button with google
                    TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 30,
                      ),
                      label: Text('Login with Google'),
                    ),

                    // login button with facebook
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffEBF0FF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.facebook_outlined,
                          color: Color(0xff4092FF),
                        ),
                        label: Text(
                          'Login with Facebook',
                          style: TextStyle(
                            color: Color(0xff9098B1),
                          ),
                        ),
                      ),
                    ),

                    // forget password text clickable
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password?',
                      ),
                    ),

                    // don't have account text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have a account?"),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _loginMethod() async {
    bool isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      setState(() => isLoading = true);

      final Response response = await Dio().post(
        'https://student.valuxapps.com/api/login',
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      // debugging
      print('this is a response : $response');

      final message = response.data['message'];
      print('this is a message : $message');

      final status = (response.data['status'] ?? false) as bool;
      print('this is a status : $status');

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: status ? Colors.green : Colors.red,
        ),
      );

      // if status true -> home page
      if (status) {
        final token = response.data['data']['token'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(PrefKeys.accessToken, token);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return HomeScreen();
            },
          ),
          (route) => false,
        );
      }
    }
  }
}
// {
//     "status": true,
//     "message": "تم تسجيل الدخول بنجاح",
//     "data": {
//         "id": 4671,
//         "name": "you",
//         "email": "you@gmail.com",
//         "phone": "987512345",
//         "image": "https://student.valuxapps.com/storage/uploads/users/6KK7AA4Ku7_1633493470.jpeg",
//         "points": 0,
//         "credit": 0,
//         "token": "L1lbbYCp86HUPEJ51pS4hNOxW6WXpPhBr6jIu5N1YhnbaqIgsQZunenZmeLXwBf0bnXoVL"
//     }
// }
