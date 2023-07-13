# Minimal HTTP Client 

A Dart package based on Dio that provides minimal http client to handle HTTP services requests. A minimal http client library for network call 

![Bitbucket open issues](https://img.shields.io/bitbucket/issues-raw/champ96k/minimal_http_client)


## Usage

[Example](https://github.com/champ96k/minimal_http_client/tree/main/example)

To use this package :

- add the dependency to your [pubspec.yaml](https://github.com/champ96k/minimal_http_client/blob/main/example/pubspec.yaml) file.

```yaml
dependencies:
  flutter:
    sdk: flutter

  minimal_http_client: ^0.0.3
```

### How to use `minimal_http_client`


1. At your app start-up initialize below `DioHttpService` or you can also add into your `dependency injection`


```dart
    final authInterceptor = AuthInterceptor(
        headerCallback: () => {
          'auth_token':'Bearer your_jwt_token',
          'seassion_key': 'my_seassion_key',
        },
      );
      await DioHttpService().init(authInterceptor: authInterceptor);
```

2. How to used in `repository`


```dart


class YourRepositoryName {
  YourRepositoryName({required this.httpService});

  /// HttpService is a dependency injection for making HTTP requests
  final HttpService httpService;

  ///Function for getting the list of fantasy matches
  Future<YourModelClass> fetchData() async {
    try {
      
      /// URL for the list of fantasy matches
      final path = '${yourBaseURL}get/news/1';

      /// Send a GET request to the specified URL with authorization and auth headers
      final _response = await httpService.handleGetRequest(path);

      /// If the response status code is between 200 and 300, parse the response data into a YourModelClass and return it
      if (_response.statusCode! >= 200 && _response.statusCode! <= 300) {
        final _result = YourModelClass.fromJson(_response.data);
        return _result;
      }
    }
    /// Catch DioError and throw a to your Custom error with the error message
    on DioError catch (e) {
      final _message = e.response?.data?['message'] ?? '';
      throw _message;
    }
    /// Catch all other exceptions and throw a CustomError with the error message
    catch (e) {
      throw '$e';
    }
  }
}
```




### Created & Maintained By

[Tushar Nikam](https://champ96k.github.io)

<a href="https://www.twitter.com/champ_96k"><img src="https://img.shields.io/badge/twitter-%231DA1F2.svg?&style=for-the-badge&logo=twitter&logoColor=white" height=25> </a>
<br>
<a href="https://www.linkedin.com/in/tushar-nikam-a29a97131/"><img src="https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" height=25></a>