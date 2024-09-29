
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_example/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		Widget createWidgetUnderTest() {
			return MaterialApp(
				home: Scaffold(
					body: BlocProvider<AuthCubit>(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);
		}

		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(createWidgetUnderTest());

			expect(find.byType(TextField), findsNWidgets(2)); // Email and Password fields
			expect(find.byKey(Key('emailField')), findsOneWidget);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(createWidgetUnderTest());

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthLoggedIn] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => <AuthState>[
				AuthLoading(),
				AuthLoggedIn(),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => <AuthState>[
				AuthLoading(),
				AuthError('Login failed'),
			],
		);
	});
}
