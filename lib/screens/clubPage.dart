import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app/screens/schoolHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../database/club_hierarchy.dart';

class ClubScreen extends StatefulWidget {
  final Club club;
  final bool trash;
  final String state;
  final String stateID;
  final String district;
  final String school;
  final String docID;

  const ClubScreen(this.club, this.trash, this.state, this.stateID,
      this.district, this.school, this.docID,
      {Key? key})
      : super(key: key);

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  void deleteClub() async {
    try {
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection('states')
          .doc(widget.stateID)
          .collection('districts')
          .doc(widget.district)
          .collection('schools')
          .doc(widget.school)
          .collection('clubs')
          .doc(widget.docID);

      await documentRef.delete();

      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.club.clubName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .25,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // color: Colors.black.withOpacity(0.7),
              ),
              child: Image.network(
                widget.club.imageURL,
                height: 100,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      height: MediaQuery.of(context).size.height * .15,
                      width: MediaQuery.of(context).size.height,
                      child: Text(
                        widget.club.clubDescription,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contact Information',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.height,
                      child: Text(
                        widget.club.contact,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Apply Here!',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewScreen(url: widget.club.link),
                        ),
                      );
                    },
                    child: Text(
                      widget.club.link,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  if (widget.trash)
                    ElevatedButton(
                        onPressed: () {
                          deleteClub();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SchoolPage(
                                    widget.state,
                                    widget.district,
                                    widget.school,
                                    widget.stateID,
                                    true)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 252, 101, 90),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .65, 50)),
                        child: Icon(
                          Icons.delete,
                          color: const Color.fromARGB(255, 130, 19, 19),
                          size: 40,
                        )),
                  // SingleChildScrollView(
                  //   child: Container(
                  //     decoration: BoxDecoration(border: Border.all(width: 1)),
                  //     height: MediaQuery.of(context).size.height * .07,
                  //     width: MediaQuery.of(context).size.height,
                  //     child: Text(widget.club.link),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
            )
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Here'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
      ),
    );
  }
}
