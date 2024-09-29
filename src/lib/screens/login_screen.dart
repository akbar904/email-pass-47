
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final TextEditingController emailController = TextEditingController();
		final TextEditingController passwordController = TextEditingController();

		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						TextField(
							key: Key('emailField'),
							controller: emailController,
							decoration: InputDecoration(
								labelText: 'Email',
							),
							keyboardType: TextInputType.emailAddress,
						),
						TextField(
							key: Key('passwordField'),
							controller: passwordController,
							decoration: InputDecoration(
								labelText: 'Password',
							),
							obscureText: true,
						),
						SizedBox(height: 20),
						ElevatedButton(
							onPressed: () {
								final String email = emailController.text;
								final String password = passwordController.text;

								context.read<AuthCubit>().login(email, password);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
