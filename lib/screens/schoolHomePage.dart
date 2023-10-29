import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/screens/chosen_button.dart';
import 'package:club_app/screens/clubPage.dart';
import 'package:club_app/screens/new_club.dart';
import 'package:club_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../database/club_hierarchy.dart';

class SchoolPage extends StatefulWidget {
  final String state;
  final String stateID;
  final String district;
  final String school;
  final bool educator;

  const SchoolPage(
      this.state, this.district, this.school, this.stateID, this.educator,
      {Key? key})
      : super(key: key);

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  String keyword = '';
  bool hasClubs = false;
  bool checked = false;
  List<QueryDocumentSnapshot<Object?>> allClubs = [];
  List<QueryDocumentSnapshot<Object?>> filteredClubs = [];

  @override
  void initState() {
    super.initState();
    fetchClubsFromFirestore();
  }

  Future<void> fetchClubsFromFirestore() async {
    try {
      QuerySnapshot<Object?> schoolSnapshot = await FirebaseFirestore.instance
          .collection('states')
          .doc(widget.stateID)
          .collection('districts')
          .doc(widget.district)
          .collection('schools')
          .doc(widget.school)
          .collection('clubs')
          .get();

      setState(() {
        allClubs.addAll(schoolSnapshot.docs);
        filteredClubs.addAll(schoolSnapshot.docs);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterClubs() {
    setState(() {
      filteredClubs = allClubs.where((club) {
        Map<String, dynamic>? clubData = club.data() as Map<String, dynamic>?;
        if (clubData != null) {
          String clubName =
              clubData.containsKey('clubName') ? clubData['clubName'] : '';
          String clubDescription = clubData.containsKey('clubDescription')
              ? clubData['clubDescription']
              : '';
          return clubName.toLowerCase().contains(keyword.toLowerCase()) ||
              clubDescription.toLowerCase().contains(keyword.toLowerCase());
        }
        return false;
      }).toList();
    });
  }

  Future<bool> checkIfCollectionHasDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('states')
        .doc(widget.stateID)
        .collection('districts')
        .doc(widget.district)
        .collection('schools')
        .doc(widget.school)
        .collection('clubs')
        .get();

    int numOfDocs = querySnapshot.size;
    return numOfDocs > 0;
  }

  void check() {
    checkIfCollectionHasDocuments().then((numOfDocs) {
      //print(checked);
      setState(() {
        hasClubs = numOfDocs;
        checked = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ChosenButton()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.school),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (checked == false)
              const CircularProgressIndicator()
            else if (checked && !hasClubs)
              const Text('Looks like you have no clubs registered yet!')
            else
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            keyword = value;
                          });
                          filterClubs();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search for a club',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
                        itemCount: filteredClubs.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot<Object?> clubSnapshot =
                              filteredClubs[index];
                          Club club = Club(
                              clubName: clubSnapshot['clubName'],
                              clubDescription: clubSnapshot['clubDescription'],
                              imageURL: clubSnapshot['imageURL'],
                              contact: clubSnapshot['contact'],
                              link: clubSnapshot['link']);

                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClubScreen(
                                        club,
                                        widget.educator,
                                        widget.state,
                                        widget.stateID,
                                        widget.district,
                                        widget.school,
                                        clubSnapshot.id)),
                              );
                            },
                            title: Text(
                              club.clubName,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              club.clubDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                            // leading: Image.network(club.imageURL),
                            leading: ClipOval(
                              child: Image.network(
                                club.imageURL,
                                height: 100,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const Expanded(flex: 1, child: Text('Hello'))
                  ])),
          ],
        ),
      ),
      floatingActionButton: widget.educator
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewClub(
                      widget.state,
                      widget.district,
                      widget.school,
                      widget.stateID,
                    ),
                  ),
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null, // Set to null to hide the FAB when the condition is false.
    );
  }
}
