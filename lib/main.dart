import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/data/models/book.dart';
import 'package:isar_flutter_starter/data/repositories/book.repository.dart';
import 'package:isar_flutter_starter/presentation/screen/author.screen.dart';
import 'package:isar_flutter_starter/presentation/screen/detailAuthor.screen.dart';
import 'package:isar_flutter_starter/presentation/screen/detailBook.screen.dart';
import 'package:isar_flutter_starter/presentation/screen/book.screen.dart';
import 'package:isar_flutter_starter/presentation/widget/bookCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Books App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  _ChangeIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  final List<Widget> screens = [const Bookscreen(), const Authorscreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          _ChangeIndex(newIndex);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Authors'),
        ],
      ),
    );
  }
}
