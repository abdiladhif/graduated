import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_graduated/provide/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:project_graduated/screens/result_screen.dart';
import 'package:project_graduated/service/inheritance_calculation.dart';
import 'package:provider/provider.dart';
import 'results_page.dart'; // Import the 

class InheritanceCalculator extends StatefulWidget {
  @override
  _InheritanceCalculatorState createState() => _InheritanceCalculatorState();
}

class _InheritanceCalculatorState extends State<InheritanceCalculator> {
  final TextEditingController _propertyValueController = TextEditingController();
  final TextEditingController _numSonsController = TextEditingController();
  final TextEditingController _numDaughtersController = TextEditingController();
  final TextEditingController _numBrothersController = TextEditingController();
  final TextEditingController _numSistersController = TextEditingController();
  final TextEditingController _numWivesController = TextEditingController();

  String _gender = "Dhadig/Dumar";
  bool _fatherPresent = false;
  bool _motherPresent = false;
  bool _paternalGrandmotherPresent = false;
  bool _paternalGrandfatherPresent = false;
  bool _husbandPresent = false;

  void _calculateAndNavigate() async {
    try {
      double propertyValue = double.tryParse(_propertyValueController.text) ?? -1;
      int numSons = int.tryParse(_numSonsController.text) ?? -1;
      int numDaughters = int.tryParse(_numDaughtersController.text) ?? -1;
      int numBrothers = int.tryParse(_numBrothersController.text) ?? -1;
      int numSisters = int.tryParse(_numSistersController.text) ?? -1;
      int numWives = _gender == "Lab/Rag" ? int.tryParse(_numWivesController.text) ?? -1 : 0;

      if (propertyValue <= 0 || numSons < 0 || numDaughters < 0 || numBrothers < 0 || numSisters < 0 || (_gender == "Male/Man" && numWives < 0 )) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Meel Banan Baa Jirto.Fadlan Xog Gali.'),
        ));
        return;
      }

     if (_gender == "Lab/Rag" && (numWives < 0 || numWives > 4)) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Fadlan tira sax xasaska ugu badan waxay noqon karaa 4 fadlan tiro sax ah gali'),
  ));
  return;
}

      var result = calculateInheritance(
        gender: _gender,
        propertyValue: propertyValue,
        numSons: numSons,
        numDaughters: numDaughters,
        numBrothers: numBrothers,
        numSisters: numSisters,
        numWives: numWives,
        fatherPresent: _fatherPresent,
        motherPresent: _motherPresent,
        paternalGrandmotherPresent: _paternalGrandmotherPresent,
        paternalGrandfatherPresent: _paternalGrandfatherPresent,
        husbandPresent: _husbandPresent,
      );

      // Filter out fields with zero values
      var filteredShares = {};
      result['shares'].forEach((key, value) {
        if (value != 0) {
          filteredShares[key] = value;
        }
      });

      // Data to be sent to the server
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userEmail = userProvider.user?.email ?? ''; // Fallback email if user is null
      var data = {
        'email': userEmail,
        'result': {
          'Qaybta': filteredShares,
          'references': result['references'],
          'LacagtaGuud': propertyValue,
          'Jinsi': _gender,
        }
      };

      // Send data to the server
      var response = await http.post(
        Uri.parse('https://inheritance.up.railway.app/results'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(result: result),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to save data: ${response.body}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Xisaabinta Dhaxalka'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsPage(email: '${user.email}')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('User not logged in'),
                ));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                value: _gender,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                items: <String>['Dhadig/Dumar', 'Lab/Rag']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: _propertyValueController,
                decoration: InputDecoration(labelText: 'Lacagta Ladhaxlaayo'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _numSonsController,
                decoration: InputDecoration(labelText: 'Tirada Wiilasha'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _numDaughtersController,
                decoration: InputDecoration(labelText: 'Tirada Gabdhaha'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _numBrothersController,
                decoration: InputDecoration(labelText: 'Tirada wilash walaalaha ah '),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _numSistersController,
                decoration: InputDecoration(labelText: 'Tirada gabdhaha walalaha ah'),
                keyboardType: TextInputType.number,
              ),
              if (_gender == "Lab/Rag")
                TextField(
                  controller: _numWivesController,
                  decoration: InputDecoration(labelText: 'tirada xasaska'),
                  keyboardType: TextInputType.number,
                ),
              SwitchListTile(
                title: Text("aabe wa joga"),
                value: _fatherPresent,
                onChanged: (bool value) {
                  setState(() {
                    _fatherPresent = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text("hooyo waa jogta"),
                value: _motherPresent,
                onChanged: (bool value) {
                  setState(() {
                    _motherPresent = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text("ayeeyo waa jogta"),
                value: _paternalGrandmotherPresent,
                onChanged: (bool value) {
                  setState(() {
                    _paternalGrandmotherPresent = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text("awoowe waa jooga"),
                value: _paternalGrandfatherPresent,
                onChanged: (bool value) {
                  setState(() {
                    _paternalGrandfatherPresent = value;
                  });
                },
              ),
              if (_gender == "Dhadig/Dumar")
                SwitchListTile(
                  title: Text("ninkeeda waa joga"),
                  value: _husbandPresent,
                  onChanged: (bool value) {
                    setState(() {
                      _husbandPresent = value;
                    });
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateAndNavigate,
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}