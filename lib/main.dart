import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApplication(),
    );
  }
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  int counter = 1;
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  late ValueNotifier<List<String>> _itemsNotifier;
  late ValueNotifier<int> _counterNotifier;

  @override
  void initState() {
    super.initState();
    _itemsNotifier = ValueNotifier([]);
    _counterNotifier = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterNotifier.value++;
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Counter App',
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Value Listenable Builder are used to listen to the changes in the value notifier...
              ValueListenableBuilder(
                  valueListenable: _counterNotifier,
                  builder: (_, int value, __) {
                    return Center(
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }),
              ValueListenableBuilder(
                valueListenable: _itemsNotifier,
                builder: (_, List<String> values, __) {
                  return Text(
                    values.join(', '),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () {
                  _itemsNotifier.value = [
                    ..._itemsNotifier.value,
                    'Item $counter',
                  ];
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _counterNotifier.dispose();
    _itemsNotifier.dispose();
    super.dispose();
  }
}
