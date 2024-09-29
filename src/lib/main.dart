
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => AuthCubit(),
			child: MaterialApp(
				title: 'Flutter Cubit Example',
				theme: ThemeData(
					primarySwatch: Colors.blue,
				),
				home: LoginScreen(),
				routes: {
					'/home': (context) => HomeScreen(),
				},
			),
		);
	}
}
