import 'package:flutter/material.dart';
import 'package:smart_flutter/smart_flutter.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    $debugPrint("Hello Example");
    return Scaffold(
      body: Center(
        child: Text("Hello".suffix("Example", infix: " ")),
      ),
    );
  }
}
