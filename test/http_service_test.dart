import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_http_client/http_service.dart';

void main() {
  test('Minimal HTTP client example', () async {
    final dioHttpService = DioHttpService();
    final authInterceptor = AuthInterceptor(
      headerCallback: () => {
        'auth_token':
            'Bearer ${DateTime.now().minute}: ${DateTime.now().second}',
        'seassion_key': 'my_seassion_key',
      },
    );
    await dioHttpService.init(authInterceptor: authInterceptor);
  });
}
