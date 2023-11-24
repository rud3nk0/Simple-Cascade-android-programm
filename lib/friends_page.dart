import 'dart:math';

import 'package:flutter/material.dart';
import 'package:santa/friend.dart';
import 'package:santa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsPage extends StatefulWidget {
  static const routeName = "/friends";

  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String? _teamName;

  List<Friend> _friens = [];

  List<Color> _colors = [
    Colors.red,
    Colors.yellow,
    Colors.black,
    Colors.green,
    Colors.lightGreen,
  ];

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final teamName = prefs.getString(teamNameKey);

    print("Loaded name = $teamName");

    setState(() {
      _teamName = teamName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_teamName ?? ""),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: _friens.length,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: const Icon(Icons.plus_one),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.purpleAccent.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          children: [
            SizedBox(width: 20),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: _friens[index].color, shape: BoxShape.circle),
            ),
            SizedBox(width: 20),
            Text(
              _friens[index].name,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return SizedBox(
      height: 10,
    );
  }

  Future<void> _add() async {
    final friend = Friend(
      _friens.length,
      "My Friend",
      _colors[Random().nextInt(_colors.length)],
    );
    setState(() {
      _friens.add(friend);
    });
  }
}
