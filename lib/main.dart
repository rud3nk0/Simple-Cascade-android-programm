import 'package:flutter/material.dart';
import 'package:santa/friends_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String teamNameKey = "TEAM_NAME";
void main() {
  _prepareAndRun();
}

Future<void> _prepareAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final teamName = prefs.getString(teamNameKey);

  runApp(MyApp(
    teamName: teamName,
  ));
}

class MyApp extends StatelessWidget {
  final String? teamName;

  const MyApp({super.key, this.teamName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        FriendsPage.routeName: (BuildContext context) => const FriendsPage(),
        MyHomePage.routeName: (BuildContext context) => const MyHomePage(),
      },
      initialRoute:
          teamName == null ? MyHomePage.routeName : FriendsPage.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = "/home";

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  void innitState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.text);
    });
  }

  Future<void> _goNext() async {
    Navigator.of(context).pushNamed(FriendsPage.routeName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(teamNameKey, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Santa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Write Group Name',
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goNext,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ),
    );
  }
}
