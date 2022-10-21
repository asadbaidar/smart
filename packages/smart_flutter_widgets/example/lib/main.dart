import 'package:flutter/material.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

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

const items = ['A', 'B', 'C', 'D', 'E', 'F'];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SmartListView<String>.builder(
          topSliverBuilder: (context) => SmartAppBar.sliver(
            title: "Smart Home",
            progress: const SmartLinearProgress.standard(),
            onRefresh: () => Future.delayed(const Duration(seconds: 2)),
            actions: [
              SmartSvgImage.asset(
                "assets/icon/bag.svg",
                width: 20,
                height: 20,
              ),
            ],
          ),
          items: items,
          divider: const SmartDivider.notLeading(),
          edgeDivider: const SmartDivider.full(),
          itemBuilder: (context, index, data) {
            return SmartListTile.simple(
              leading: Text(data!),
              title: data,
              color: Colors.primaries[index],
              accessory: const Icon(Icons.check),
              tintAccessory: true,
              padAccessory: true,
              onTap: () {},
            );
          },
        ),
      );
}
