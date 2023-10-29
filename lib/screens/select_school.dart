// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../database/club_hierarchy.dart';

// class SelectSchool extends StatefulWidget {
//   const SelectSchool({super.key});

//   @override
//   State<SelectSchool> createState() => _SelectSchoolState();
// }

// class _SelectSchoolState extends State<SelectSchool> {
//   List<DropdownMenuItem<String>> districtItems = [];
//   String? selectedState;
//   String? district;
//   String? school;

//   String? selectedDocumentId;
//   List<String> documentIds = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDocumentIds();
//   }

//   Future<void> fetchDocumentIds() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('states')
//           .doc('AL')
//           .collection('districts') // Replace with your collection name
//           .get();

//       List<String> ids = snapshot.docs.map((doc) => doc.id).toList();

//       setState(() {
//         documentIds = ids;
//       });
//     } catch (e) {
//       print('Error retrieving document IDs: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Select a State:',
//           style: TextStyle(fontSize: 18),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedState,
//           items: states.map((state) {
//             return DropdownMenuItem<String>(
//               value: state.id,
//               child: Text(state.name),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedState = value!;
//               districtItems = []; // Clear the district items when state changes
//             });
//             fetchDistricts(
//                 selectedState!); // Fetch districts based on the selected state
//           },
//         ),
//         const SizedBox(height: 16),
//         if (selectedState != null)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'District:',
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 8),
//               // DropdownButtonFormField<String>(
//               //   value: selectedDocumentId,
//               //   items: documentIds.map((id) {
//               //     return DropdownMenuItem<String>(
//               //       value: id,
//               //       child: Text(id),
//               //     );
//               //   }).toList(),
//               //   onChanged: (value) {
//               //     setState(() {
//               //       selectedDocumentId = value;
//               //     });
//               //   },
//               // ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 onChanged: (value) {
//                   setState(() {
//                     school = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               if (school != null && district != null)
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add your registration logic here
//                   },
//                   child: const Text('Register'),
//                 ),
//             ],
//           ),
//       ],
//     );
//   }

//   Future<void> fetchDistricts(String stateId) async {
//     final districtDocs = await FirebaseFirestore.instance
//         .collection('states')
//         .doc(stateId)
//         .collection('districts')
//         .get();

//     final districts = districtDocs.docs.map((doc) {
//       return DropdownMenuItem<String>(
//         value: doc.id,
//         child: Text(doc['name']),
//       );
//     }).toList();

//     setState(() {
//       districtItems = districts;
//     });
//   }
// }

// List<States> states = [
//   States(id: 'AL', name: 'Alabama'),
//   States(id: 'AK', name: 'Alaska'),
//   States(id: 'AZ', name: 'Arizona'),
//   States(id: 'AR', name: 'Arkansas'),
//   States(id: 'CA', name: 'California'),
//   States(id: 'CO', name: 'Colorado'),
//   States(id: 'CT', name: 'Connecticut'),
//   States(id: 'DE', name: 'Delaware'),
//   States(id: 'FL', name: 'Florida'),
//   States(id: 'GA', name: 'Georgia'),
//   States(id: 'HI', name: 'Hawaii'),
//   States(id: 'ID', name: 'Idaho'),
//   States(id: 'IL', name: 'Illinois'),
//   States(id: 'IN', name: 'Indiana'),
//   States(id: 'IA', name: 'Iowa'),
//   States(id: 'KS', name: 'Kansas'),
//   States(id: 'KY', name: 'Kentucky'),
//   States(id: 'LA', name: 'Louisiana'),
//   States(id: 'ME', name: 'Maine'),
//   States(id: 'MD', name: 'Maryland'),
//   States(id: 'MA', name: 'Massachusetts'),
//   States(id: 'MI', name: 'Michigan'),
//   States(id: 'MN', name: 'Minnesota'),
//   States(id: 'MS', name: 'Mississippi'),
//   States(id: 'MO', name: 'Missouri'),
//   States(id: 'MT', name: 'Montana'),
//   States(id: 'NE', name: 'Nebraska'),
//   States(id: 'NV', name: 'Nevada'),
//   States(id: 'NH', name: 'New Hampshire'),
//   States(id: 'NJ', name: 'New Jersey'),
//   States(id: 'NM', name: 'New Mexico'),
//   States(id: 'NY', name: 'New York'),
//   States(id: 'NC', name: 'North Carolina'),
//   States(id: 'ND', name: 'North Dakota'),
//   States(id: 'OH', name: 'Ohio'),
//   States(id: 'OK', name: 'Oklahoma'),
//   States(id: 'OR', name: 'Oregon'),
//   States(id: 'PA', name: 'Pennsylvania'),
//   States(id: 'RI', name: 'Rhode Island'),
//   States(id: 'SC', name: 'South Carolina'),
//   States(id: 'SD', name: 'South Dakota'),
//   States(id: 'TN', name: 'Tennessee'),
//   States(id: 'TX', name: 'Texas'),
//   States(id: 'UT', name: 'Utah'),
//   States(id: 'VT', name: 'Vermont'),
//   States(id: 'VA', name: 'Virginia'),
//   States(id: 'WA', name: 'Washington'),
//   States(id: 'WV', name: 'West Virginia'),
//   States(id: 'WI', name: 'Wisconsin'),
//   States(id: 'WY', name: 'Wyoming'),
// ];
// //   States? selectedState;
// //   String? district;
// //   String? school;

// //   String? selectedDistrict;
// //   List<DropdownMenuItem<String>> districtItems = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchDistricts();
// //   }

// //   Future<void> fetchDistricts() async {
// //     final districtDocs = await FirebaseFirestore.instance
// //         .collection('states')
// //         .doc(selectedState!.getName())
// //         .collection('districts')
// //         .get();

// //     final districts = districtDocs.docs.map((doc) {
// //       return DropdownMenuItem<String>(
// //         value: doc.id,
// //         child: Text(doc['name']),
// //       );
// //     }).toList();

// //     setState(() {
// //       districtItems = districts;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Select Your School'),
// //       ),
// //       body: Container(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'Select a State:',
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             const SizedBox(height: 8),
// //             DropdownButtonFormField<States>(
// //               value: selectedState,
// //               items: states.map((state) {
// //                 return DropdownMenuItem<States>(
// //                   value: state,
// //                   child: Text(state.name),
// //                 );
// //               }).toList(),
// //               onChanged: (value) async {
// //                 setState(() {
// //                   selectedState = value!;
// //                 });

// //                 final districtDocs = await FirebaseFirestore.instance
// //                     .collection('states')
// //                     .doc(selectedState!.getName())
// //                     .collection('districts')
// //                     .get();

// //                 final districts = districtDocs.docs.map((doc) {
// //                   return DropdownMenuItem<String>(
// //                     value: doc.id,
// //                     child: Text(doc['name']),
// //                   );
// //                 }).toList();

// //                 setState(() {
// //                   districtItems = districts;
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //             if (selectedState != null)
// //               DropdownButtonFormField<String>(
// //                 value: selectedDistrict,
// //                 items: districtItems,
// //                 onChanged: (value) {
// //                   setState(() {
// //                     selectedDistrict = value;
// //                   });
// //                 },
// //                 decoration: InputDecoration(
// //                   labelText: 'Select District',
// //                 ),
// //               ),
// //             if (selectedDistrict != null)
// //               ElevatedButton(
// //                 onPressed: () {},
// //                 child: const Text('Register'),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/screens/register_screen.dart';
import 'package:club_app/screens/schoolHomePage.dart';
import 'package:flutter/material.dart';

import '../database/club_hierarchy.dart';

class SelectSchool extends StatefulWidget {
  const SelectSchool({super.key});

  @override
  State<SelectSchool> createState() => _SelectSchoolState();
}

class _SelectSchoolState extends State<SelectSchool> {
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
  List<String> districts = [];
  List<String> schools = [];
  String? password;
  String? rpw;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchDocumentIDs().then((documentIDs) {
  //     setState(() {
  //       districts = documentIDs;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Your School'),
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
                districts = [];
                schools = [];
                district = null;
                school = null;
                fetchDocumentIDs(selectedState!.getID(), true, '')
                    .then((documentIDs) {
                  setState(() {
                    districts = documentIDs;
                  });
                });
                // print(districts);
              },
            ),
            const SizedBox(height: 32),
            if (selectedState != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a District:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: district,
                    items: districts.map((district) {
                      return DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        district = value!;
                      });
                      schools = [];
                      school = null;
                      fetchDocumentIDs(selectedState!.getID(), false, district!)
                          .then((documentIDs) {
                        setState(() {
                          schools = documentIDs;
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedState != null && district != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a School:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: school,
                          items: schools.map((school) {
                            return DropdownMenuItem<String>(
                              value: school,
                              child: Text(school),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              school = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        if (selectedState != null &&
                            district != null &&
                            school != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Enter the password:',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              if (selectedState != null &&
                                  district != null &&
                                  school != null &&
                                  password != null)
                                ElevatedButton(
                                  onPressed: () {
                                    getPW(selectedState!.getID(), district!,
                                            school!)
                                        .then((fieldValue) {
                                      setState(() {
                                        rpw = fieldValue;
                                      });
                                      if (rpw == password) {
                                        // print("corect");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SchoolPage(
                                                  selectedState!.getName(),
                                                  district!,
                                                  school!,
                                                  selectedState!.getID(),
                                                  true)),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Incorrect Password'),
                                              content: const Text(
                                                  'Please enter the correct password.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    });
                                  },
                                  child: const Text('Submit'),
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                      ],
                    )
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't see your school? ",
                    style: TextStyle(color: Colors.black)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Click here to register!",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                // Text('to register.', style: TextStyle(color: Colors.black))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List<String>> fetchDocumentIDs(
      String st, bool dors, String dis) async {
    List<String> documentIDs = [];

    try {
      if (dors) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('states')
            .doc(st)
            .collection('districts')
            .get();
        for (var doc in snapshot.docs) {
          documentIDs.add(doc.id);
        }
      } else {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('states')
            .doc(st)
            .collection('districts')
            .doc(dis)
            .collection('schools')
            .get();
        for (var doc in snapshot.docs) {
          documentIDs.add(doc.id);
        }
      }
    } catch (e) {
      print('Error retrieving document IDs: $e');
    }

    return documentIDs;
  }

  String? fieldValue;

  Future<String> getPW(String st, String dis, String sch) async {
    String fieldValue = '';
    Map<String, dynamic>? fieldData;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('states')
          .doc(st)
          .collection('districts')
          .doc(dis)
          .collection('schools')
          .doc(sch)
          .get();

      // Access the field using the field name
      fieldData = snapshot.data() as Map<String, dynamic>?;

      // Check if fieldData is not null and contains the desired field
      // Assign the field value to a variable
      fieldValue = fieldData!['password'].toString();
      return fieldValue;
    } catch (error) {
      print('Error getting document: $error');
      return fieldValue;
    }
  }
}
