import 'dart:math';

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? _prefs;

  num _height = 0, _weight = 0, _bmi = 0;

  List<String> _bmiHistory = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then(
      (value) => {
        setState(() {
          _prefs = value;
          _bmiHistory = _prefs!.getStringList("bmi_history") ?? [];
          _height = _prefs!.getDouble("last_input_height")?.toDouble() ?? 0;
          _weight = _prefs!.getDouble("last_input_weight")?.toDouble() ?? 0;
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_prefs == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.05,
          child: Center(
            child: Text(
              "${_bmiHistory.lastOrNull ?? 0.00}  BMI",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _weightInput(),
            _heightInput(),
          ],
        ),
        _calculateBMIButton(),
        _bmiHistoryList()
      ],
    ));
  }

  Widget _weightInput() {
    return Column(
      children: [
        const Text("Weight"),
        InputQty(
          maxVal: double.infinity,
          initVal: _weight,
          minVal: 0,
          steps: 1,
          onQtyChanged: (value) {
            setState(() {
              _weight = value;
              _prefs!.setDouble("last_input_weight", _weight.toDouble());
            });
          },
        )
      ],
    );
  }

  Widget _heightInput() {
    return Column(
      children: [
        const Text("Height"),
        InputQty(
          maxVal: double.infinity,
          initVal: _height,
          minVal: 0,
          steps: 1,
          onQtyChanged: (value) {
            setState(() {
              _height = value;
              _prefs!.setDouble("last_input_height", _height.toDouble());
            });
          },
        )
      ],
    );
  }

  Widget _calculateBMIButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: MaterialButton(
        onPressed: () {
          double CalculateBmi = _weight / pow(_height, 2);
          //print(CalculateBmi);
          setState(() {
            _bmiHistory.add(CalculateBmi.toStringAsFixed(2));
            _prefs!.setStringList("bmi history", _bmiHistory);
          });
        },
        color: Colors.purple,
        child: Text(
          "Calculate",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _bmiHistoryList() {
    return Expanded(
        child: ListView.builder(
            itemCount: _bmiHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  index.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                title: Text(_bmiHistory[index]),
                onLongPress: () {
                  setState(() {
                    _bmiHistory.removeAt(index);
                    _prefs!.setStringList("bmi_history", _bmiHistory);
                  });
                },
              );
            }));
  }
}
