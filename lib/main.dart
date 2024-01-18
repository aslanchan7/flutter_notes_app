import 'package:first_desktop_app/models/note_database.dart';
import 'package:first_desktop_app/models/notes_view_provider.dart';
import 'package:first_desktop_app/pages/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize the note_database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  await NotesViewProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Notes Provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        // Notes View Provider
        ChangeNotifierProvider(create: (context) => NotesViewProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    Text("Profile Page"),
  ];

  bool sideBarActivated(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Notes App"),
        ),
      ),
      body: Row(
        children: [
          // Side Bar
          if (sideBarActivated(context))
            Container(
              // constraints: const BoxConstraints(maxWidth: 200, minWidth: 100),
              width: 200,
              color: Colors.deepPurple.shade50,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: const Text(
                      "Navigation Panel",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text("All Notes"),
                    leading: const Icon(Icons.notes),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      _onItemTapped(0);
                    },
                  ),
                  ListTile(
                    title: const Text("Profile"),
                    leading: const Icon(Icons.person),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                    },
                  ),
                ],
              ),
            ),

          // Page Content
          Expanded(
            flex: 5,
            child: Container(
              child: _widgetOptions[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
