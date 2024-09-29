
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_example/main.dart';

// Mock dependencies if needed
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Tests', () {
		testWidgets('MyApp has MaterialApp', (WidgetTester tester) async {
			// Build the widget tree
			await tester.pumpWidget(MyApp());

			// Verify if MaterialApp is present
			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('MyApp routes to LoginScreen', (WidgetTester tester) async {
			// Build the widget tree
			await tester.pumpWidget(MyApp());

			// Verify if LoginScreen is the initial route
			expect(find.byType(LoginScreen), findsOneWidget);
		});

		testWidgets('MyApp initializes AuthCubit', (WidgetTester tester) async {
			// Build the widget tree
			await tester.pumpWidget(MyApp());

			// Verify if AuthCubit is provided
			expect(find.byType(BlocProvider<AuthCubit>), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		test('Initial state is AuthInitial', () {
			// Verify initial state
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthLoggedIn] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [AuthLoading(), AuthLoggedIn()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [AuthLoading(), AuthError('Login Failed')],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoggedOut] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthLoggedOut()],
		);
	});
}
