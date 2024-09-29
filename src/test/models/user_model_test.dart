
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_example/models/user_model.dart';

void main() {
	group('User Model', () {
		test('should correctly deserialize from JSON', () {
			final json = {
				'email': 'test@example.com',
				'name': 'Test User',
			};
			final user = User.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});

		test('should correctly serialize to JSON', () {
			final user = User(email: 'test@example.com', name: 'Test User');
			final json = user.toJson();

			expect(json, {
				'email': 'test@example.com',
				'name': 'Test User',
			});
		});

		test('should have correct attributes', () {
			final user = User(email: 'test@example.com', name: 'Test User');

			expect(user.email, 'test@example.com');
			expect(user.name, 'Test User');
		});
	});
}
