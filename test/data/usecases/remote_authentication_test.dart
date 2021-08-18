import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_tdd_clean_arch_app/domain/usecases/usecases.dart';

import 'package:flutter_tdd_clean_arch_app/data/usecases/usecases.dart';
import 'package:flutter_tdd_clean_arch_app/data/http/http.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  MockHttpClient httpClient;
  String url;
  RemoteAuthentication sut;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct url', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
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
}
