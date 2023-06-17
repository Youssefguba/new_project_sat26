import 'package:flutter/material.dart';
import 'package:new_project_sat26/features/authentication/screens/login_screen.dart';
import 'package:new_project_sat26/features/home/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/prefs_key_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => initData());

  }

  void initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get(PrefKeys.accessToken);

    if (token == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ), (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
