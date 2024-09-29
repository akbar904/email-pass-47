
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_example/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
	final User user;

	AuthLoggedIn(this.user);
}

class AuthError extends AuthState {
	final String message;

	AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		emit(AuthLoading());
		// Simulate a network call
		await Future.delayed(Duration(seconds: 1));

		if (email == 'test@example.com' && password == 'password123') {
			final user = User(email: email, name: 'Test User');
			emit(AuthLoggedIn(user));
		} else {
			emit(AuthError('Login failed'));
		}
	}

	void logout() {
		emit(AuthLoggedOut());
	}
}
