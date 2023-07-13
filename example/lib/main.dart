import 'package:http_service/http_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTTP Minimal client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(httpService: DioHttpService()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final HttpService httpService;
  const HomeScreen({super.key, required this.httpService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dioHttpService = DioHttpService();
  String? authToken;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authInterceptor = AuthInterceptor(
        headerCallback: () => {
          'auth_token':
              'Bearer ${DateTime.now().minute}: ${DateTime.now().second}',
          'seassion_key': 'my_seassion_key',
        },
      );
      await dioHttpService.init(authInterceptor: authInterceptor);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP Minimal client"),
      ),
      body: Center(
          child: TextButton(
        onPressed: () async {
          final result = await widget.httpService
              .handleGetRequest('https://api.publicapis.org/entries');
          debugPrint("Result: $result");
        },
        child: const Text("Get Info"),
      )),
    );
  }
}
