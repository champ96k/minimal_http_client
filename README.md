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

  minimal_http_client: ^0.0.2
```

### How to use `minimal_http_client`


1. At your app start-up initialize below `DioHttpService`


```dart
    final authInterceptor = AuthInterceptor(
        headerCallback: () => {
          'auth_token':
              'Bearer ${DateTime.now().minute}: ${DateTime.now().second}',
          'seassion_key': 'my_seassion_key',
        },
      );
      await DioHttpService().init(authInterceptor: authInterceptor);
```


### Created & Maintained By

[Tushar Nikam](https://champ96k.github.io)

<a href="https://www.twitter.com/champ_96k"><img src="https://img.shields.io/badge/twitter-%231DA1F2.svg?&style=for-the-badge&logo=twitter&logoColor=white" height=25> </a>
<br>
<a href="https://www.linkedin.com/in/tushar-nikam-a29a97131/"><img src="https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" height=25></a>