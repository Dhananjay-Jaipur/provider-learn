// ============================= PROVIDER USING CONSUMER ================================


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners(); // Notify listeners when the state changes
  }

  void decrement() {
    counter--;
    notifyListeners(); // Notify listeners when the state changes
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Implementing the lifecycle observer in MyHomePage
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    // Add observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Override didChangeAppLifecycleState to log lifecycle events
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState changed to: $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            // Using Consumer to listen for changes in the Counter provider

            Consumer<Counter>(
              builder: (context, obj, child) {
                return Text(
                  '${obj.counter}', // Display the current counter value
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),

          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<Counter>().increment(); 
              // `read` accesses Counter without listening for changes
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

          FloatingActionButton(
            onPressed: () {
              context.watch<Counter>().increment(); 
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}


// ============================= PROVIDER USING INSTANCE ================================


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // Step 1: Define the Counter class which will hold and manage the counter state
// class Counter with ChangeNotifier {
//   int counter = 0;

//   void increment() {
//     counter++;
//     notifyListeners(); // Notify listeners when the state changes
//   }

//   void decrement() {
//     counter--;
//     notifyListeners(); // Notify listeners when the state changes
//   }
// }

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => Counter(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'untitled',
//       home: MyHomePage(title: 'Flutter Demo',),
//     );
//   }
// }


// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {

//     final counter = Provider.of<Counter>(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${counter.counter}', // Display the current counter value
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               // Step 4: Increment the counter when the button is pressed
//               counter.increment(); // Directly call the increment method from the Counter class
//             },
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ),

//           FloatingActionButton(
//             onPressed: () {
//               // Step 4: Increment the counter when the button is pressed
//               counter.decrement(); // Directly call the increment method from the Counter class
//             },
//             tooltip: 'Decrement',
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ),

     
//     );
//   }
// }
