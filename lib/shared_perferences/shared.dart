import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared extends StatefulWidget {
  const Shared({super.key});

  @override
  State<Shared> createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  var nameController = TextEditingController();
  static const String KEYNAME = "name";
  var nameValue = "No Value Saved";
  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared perfer'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  label: const Text("Name"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
            ),
            const SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () async {
                  var name = nameController.text.toString();
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString(KEYNAME, name);
                },
                child: Text("Save")),
            const SizedBox(
              height: 11,
            ),
            Text(nameValue)
          ],
        ),
      ),
    );
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString(KEYNAME);
    nameValue = getName ?? "No Value Saved";

    setState(() {});
  }
}
