import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_sat26/features/authentication/screens/login_screen.dart';

import 'features/product/cubits/product_cubit.dart';
import 'features/splash/screens/splash_screen.dart';

// entry point
void main() {
  // everything in flutter is a widget
  // widget is class
  // every class in flutter inherit from a widget class

  // 1. Material Design - Google
  // 2. Cupertino Design - Apple
  // function app run
  runApp(MyApp());
}
// 2 types of files structure
//    1. features based [ authentication , review , home, offers, notifications ]
//    2. category based [ screens, logic ]

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
