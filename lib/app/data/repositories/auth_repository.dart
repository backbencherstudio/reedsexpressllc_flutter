import 'package:dio/dio.dart';
import 'package:reedsexpressllc_flutter/app/core/network/api_client.dart';
import 'package:reedsexpressllc_flutter/app/core/network/api_endpoints.dart';
import 'package:reedsexpressllc_flutter/app/data/models/login_model.dart';

abstract class IAuthRepository {
  Future<LoginModel> login(String email, String password);
}

class AuthRepository implements IAuthRepository {
  final ApiClient _client;

  AuthRepository(this._client);

  @override
  Future<LoginModel> login(String email, String password) {
    final data = FormData.fromMap({'email': email, 'password': password});
    return _client.handleRequest(
      () => _client.dio.post(ApiEndpoint.login, data: data),
      (dynamic data) => LoginModel.fromJson(data),
      'Login',
    );
  }
}
