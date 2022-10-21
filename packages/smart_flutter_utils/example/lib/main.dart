import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

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
        child: Text("Hello".post("Example", between: " ")),
      ),
    );
  }
}
