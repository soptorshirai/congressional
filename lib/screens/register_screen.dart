import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/screens/schoolHomePage.dart';
import 'package:club_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../database/club_hierarchy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<int> numbers = [1, 2, 3, 4, 5];
  List<States> states = [
    States(id: 'AL', name: 'Alabama'),
    States(id: 'AK', name: 'Alaska'),
    States(id: 'AZ', name: 'Arizona'),
    States(id: 'AR', name: 'Arkansas'),
    States(id: 'CA', name: 'California'),
    States(id: 'CO', name: 'Colorado'),
    States(id: 'CT', name: 'Connecticut'),
    States(id: 'DE', name: 'Delaware'),
    States(id: 'FL', name: 'Florida'),
    States(id: 'GA', name: 'Georgia'),
    States(id: 'HI', name: 'Hawaii'),
    States(id: 'ID', name: 'Idaho'),
    States(id: 'IL', name: 'Illinois'),
    States(id: 'IN', name: 'Indiana'),
    States(id: 'IA', name: 'Iowa'),
    States(id: 'KS', name: 'Kansas'),
    States(id: 'KY', name: 'Kentucky'),
    States(id: 'LA', name: 'Louisiana'),
    States(id: 'ME', name: 'Maine'),
    States(id: 'MD', name: 'Maryland'),
    States(id: 'MA', name: 'Massachusetts'),
    States(id: 'MI', name: 'Michigan'),
    States(id: 'MN', name: 'Minnesota'),
    States(id: 'MS', name: 'Mississippi'),
    States(id: 'MO', name: 'Missouri'),
    States(id: 'MT', name: 'Montana'),
    States(id: 'NE', name: 'Nebraska'),
    States(id: 'NV', name: 'Nevada'),
    States(id: 'NH', name: 'New Hampshire'),
    States(id: 'NJ', name: 'New Jersey'),
    States(id: 'NM', name: 'New Mexico'),
    States(id: 'NY', name: 'New York'),
    States(id: 'NC', name: 'North Carolina'),
    States(id: 'ND', name: 'North Dakota'),
    States(id: 'OH', name: 'Ohio'),
    States(id: 'OK', name: 'Oklahoma'),
    States(id: 'OR', name: 'Oregon'),
    States(id: 'PA', name: 'Pennsylvania'),
    States(id: 'RI', name: 'Rhode Island'),
    States(id: 'SC', name: 'South Carolina'),
    States(id: 'SD', name: 'South Dakota'),
    States(id: 'TN', name: 'Tennessee'),
    States(id: 'TX', name: 'Texas'),
    States(id: 'UT', name: 'Utah'),
    States(id: 'VT', name: 'Vermont'),
    States(id: 'VA', name: 'Virginia'),
    States(id: 'WA', name: 'Washington'),
    States(id: 'WV', name: 'West Virginia'),
    States(id: 'WI', name: 'Wisconsin'),
    States(id: 'WY', name: 'Wyoming'),
  ];
  // String selectedState = " ";
  States? selectedState;
  String? district;
  String? school;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register A New School'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a State:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<States>(
              value: selectedState,
              items: states.map((state) {
                return DropdownMenuItem<States>(
                  value: state,
                  child: Text(state.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedState = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedState != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'District:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        district = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'School:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        school = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Set your password:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (school != null && district != null)
                    ElevatedButton(
                      onPressed: () {
                        // print(selectedState!.getName());
                        FirebaseFirestore.instance
                            .collection('states')
                            .doc(selectedState!.getID())
                            .set({"name": selectedState!.getName()});
                        FirebaseFirestore.instance
                            .collection('states')
                            .doc(selectedState!.getID())
                            .collection("districts")
                            .doc(district)
                            .set({"name": district});
                        FirebaseFirestore.instance
                            .collection('states')
                            .doc(selectedState!.getID())
                            .collection("districts")
                            .doc(district)
                            .collection("schools")
                            .doc(school)
                            .set({
                          "name": school,
                          "password": password,
                          "state": selectedState!.getName(),
                          "stateID": selectedState!.getID(),
                          "district": district
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThankYouForRegistering(
                                  selectedState!.getName(),
                                  district!,
                                  school!,
                                  selectedState!.getID())),
                        );
                      },
                      child: const Text('Register'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ThankYouForRegistering extends StatefulWidget {
  final String state;
  final String stateID;
  final String district;
  final String school;
  const ThankYouForRegistering(
      this.state, this.district, this.school, this.stateID,
      {Key? key})
      : super(key: key);

  @override
  State<ThankYouForRegistering> createState() => _ThankYouForRegisteringState();
}

class _ThankYouForRegisteringState extends State<ThankYouForRegistering>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 6.0).animate(_controller);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SchoolPage(
            widget.state, widget.district, widget.school, widget.stateID, true),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SpinKitFadingCube spinkit;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      //     gradient: LinearGradient(colors: [
      //   Color.fromARGB(255, 213, 215, 151),
      //   Color.fromARGB(255, 186, 186, 101),
      //   Color.fromARGB(255, 158, 138, 65)
      // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Center(
        child: FadeTransition(
            opacity: _animation,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 200,
                ),
                Text("Thank you for registering",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    )),
                const SizedBox(
                  height: 150,
                ),
                spinkit = SpinKitFadingCube(
                  color: Colors.deepPurple,
                  size: 50.0,
                )
              ],
            )),
      ),
    ));
  }
}

// List of US states
// final List<String> USStates = [
//   ' ',
//   'Alabama',
//   'Alaska',
//   'Arizona',
//   'Arkansas',
//   'California',
//   'Colorado',
//   'Connecticut',
//   'Delaware',
//   'Florida',
//   'Georgia',
//   'Hawaii',
//   'Idaho',
//   'Illinois',
//   'Indiana',
//   'Iowa',
//   'Kansas',
//   'Kentucky',
//   'Louisiana',
//   'Maine',
//   'Maryland',
//   'Massachusetts',
//   'Michigan',
//   'Minnesota',
//   'Mississippi',
//   'Missouri',
//   'Montana',
//   'Nebraska',
//   'Nevada',
//   'New Hampshire',
//   'New Jersey',
//   'New Mexico',
//   'New York',
//   'North Carolina',
//   'North Dakota',
//   'Ohio',
//   'Oklahoma',
//   'Oregon',
//   'Pennsylvania',
//   'Rhode Island',
//   'South Carolina',
//   'South Dakota',
//   'Tennessee',
//   'Texas',
//   'Utah',
//   'Vermont',
//   'Virginia',
//   'Washington',
//   'West Virginia',
//   'Wisconsin',
//   'Wyoming',
// ];
