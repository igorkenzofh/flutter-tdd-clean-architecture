import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_app/domain/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_app/domain/helpers/helpers.dart';

import 'package:flutter_tdd_clean_arch_app/data/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_app/data/http/http.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  MockHttpClient httpClient;
  String url;
  RemoteAuthentication sut;
  AuthenticationParams params;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
  });

  test('should call HttpClient with correct url', () async {
    //Act
    await sut.auth(params);

    // Assert
    verify(
      httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.password}),
    );
  });

  test('should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
    //Act
    final result = sut.auth(params);

    // Assert
    expect(result, throwsA(DomainError.unexpected));
  });
}
