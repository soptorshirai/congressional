import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/screens/schoolHomePage.dart';
import 'package:flutter/material.dart';

import '../database/club_hierarchy.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String keyword = '';
  List<QueryDocumentSnapshot<Object?>> allSchools = [];
  List<QueryDocumentSnapshot<Object?>> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    fetchSchoolsFromFirestore();
  }

  Future<void> fetchSchoolsFromFirestore() async {
    try {
      QuerySnapshot<Object?> stateSnapshot =
          await FirebaseFirestore.instance.collection('states').get();

      for (QueryDocumentSnapshot<Object?> stateDoc in stateSnapshot.docs) {
        String stateId = stateDoc.id;

        QuerySnapshot<Object?> districtSnapshot = await FirebaseFirestore
            .instance
            .collection('states')
            .doc(stateId)
            .collection('districts')
            .get();

        for (QueryDocumentSnapshot<Object?> districtDoc
            in districtSnapshot.docs) {
          String districtId = districtDoc.id;

          QuerySnapshot<Object?> schoolSnapshot = await FirebaseFirestore
              .instance
              .collection('states')
              .doc(stateId)
              .collection('districts')
              .doc(districtId)
              .collection('schools')
              .get();

          setState(() {
            allSchools.addAll(schoolSnapshot.docs);
            // filteredSchools.addAll(schoolSnapshot.docs);
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterSchools() {
    setState(() {
      filteredSchools = allSchools.where((school) {
        Map<String, dynamic>? schoolData =
            school.data() as Map<String, dynamic>?;
        if (schoolData != null) {
          String name =
              schoolData.containsKey('name') ? schoolData['name'] : '';
          String district =
              schoolData.containsKey('district') ? schoolData['district'] : '';
          String state =
              schoolData.containsKey('state') ? schoolData['state'] : '';
          return name.toLowerCase().contains(keyword.toLowerCase()) ||
              state.toLowerCase().contains(keyword.toLowerCase()) ||
              district.toLowerCase().contains(keyword.toLowerCase());
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Your School'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
                filterSchools();
              },
              decoration: const InputDecoration(
                hintText: 'Search for a school',
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Object?> schoolSnapshot =
                    filteredSchools[index];
                School school = School(
                    name: schoolSnapshot['name'],
                    state: schoolSnapshot['state'],
                    district: schoolSnapshot['district'],
                    stateID: schoolSnapshot['stateID']
                    // Add more fields as needed
                    );

                return ListTile(
                  title: Text(school.name),
                  subtitle: Text(
                      'Location: ${school.state}\nDistrict: ${school.district}'),
                  leading: const Icon(Icons.school),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SchoolPage(
                              school.state,
                              school.district,
                              school.name,
                              school.stateID,
                              false)),
                    );
                    // Handle the item tap and access school details using schoolSnapshot
                  },
                );
              },
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  'Don\'t see your school? Talk to an administrator to get your school registered!',
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.all(16),
              ))
        ],
      ),
    );
  }
}
