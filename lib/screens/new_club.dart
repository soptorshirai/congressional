import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:club_app/database/club_hierarchy.dart';
import 'package:club_app/screens/schoolHomePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class NewClub extends StatefulWidget {
  final String state;
  final String district;
  final String school;
  final String stateID;

  const NewClub(this.state, this.district, this.school, this.stateID,
      {Key? key})
      : super(key: key);

  @override
  State<NewClub> createState() => _NewClubState();
}

class _NewClubState extends State<NewClub> {
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Save the picked image to Firebase Storage
      uploadImageToFirebase(File(pickedFile.path));
    } else {
      // Handle the case when no image is picked
    }
  }

  Future<void> uploadImageToFirebase(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    // Get the image URL from the storage task snapshot
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    // Save the image URL or do any further processing

    saveImageUrlToFirestore(imageUrl);
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      // Create a document reference to the Firestore collection where you want to save the URL
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('states')
          .doc(widget.stateID)
          .collection('districts')
          .doc(widget.district)
          .collection('schools')
          .doc(widget.school)
          .collection('clubs')
          .doc();

      // Set the imageURL field in the document
      await docRef.set({
        'imageURL': imageUrl,
        'clubName': clubName,
        'clubDescription': clubDescription,
        'contact': contact,
        'link': link
      });

      print('Image URL saved to Firestore.');
    } catch (e) {
      print('Error saving image URL to Firestore: $e');
    }
  }

  File? _image;
  String? clubName;
  String? clubDescription;
  String? contact;
  String? link;
  Uri? uri;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_image != null) {
      // Show a progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Working on it...'),
              ],
            ),
          );
        },
      );

      try {
        // Call the function to upload the image to Firebase Storage and save the URL to Firestore
        await uploadImageToFirebase(_image!);
        // Clear the image selection
        setState(() {
          _image = null;
        });
      } catch (error) {
        print('Error uploading image: $error');
        // Handle the error if necessary
      } finally {
        // Dismiss the progress indicator dialog
        Navigator.pop(context);

        // Navigate to the SchoolPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SchoolPage(widget.state, widget.district,
                widget.school, widget.stateID, true),
          ),
        );
      }
    }
  }

  bool isValidUrl(String url) {
    if (url.isEmpty) return false;

    return Uri.tryParse('https://$url')?.isAbsolute ?? false;
  }

  // void checkUrlValidity(String url) async {
  //   if (isValidUrl('https://$url')) {
  //     print(isValidUrl('https://$url'));
  //     uri = Uri.parse(url);
  //     if (await canLaunchUrl(uri!)) {
  //       print('URL is valid and can be launched');
  //     } else {
  //       print('URL is valid but cannot be launched');
  //     }
  //   } else {
  //     print('Invalid URL');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Register a new club'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Stack(alignment: Alignment.center, children: [
              if (_image != null)
                ClipOval(
                  child: Image.file(
                    _image!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              if (_image == null)
                CircleAvatar(
                  radius: 100,
                  // child: Icon(
                  //   Icons.camera_alt,
                  //   size: 100,
                  // ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 100,
                    ),
                    onPressed: _showImageSourceOptions,
                  ),
                ),
              if (_image != null)
                Positioned(
                  bottom: 0,
                  right: 100,
                  child: InkWell(
                    onTap: _showImageSourceOptions,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Name of Club',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                clubName = value;
              });
            },
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            maxLines: 4,
            onChanged: (value) {
              setState(() {
                clubDescription = value;
              });
            },
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Contact Information',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            maxLines: 2,
            onChanged: (value) {
              setState(() {
                contact = value;
              });
            },
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Link to Google Form',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onChanged: (value) {
              setState(() {
                link = value;
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                if (clubName != null &&
                    clubDescription != null &&
                    link != null &&
                    contact != null) {
                  if (isValidUrl(link!)) {
                    _uploadImage(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Invalid link'),
                          content: const Text(
                              'Please attach a valid google forms link.'),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Incomplete Form'),
                        content: const Text('Please complete the form.'),
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
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  fixedSize: Size(MediaQuery.of(context).size.width * .65, 30)),
              child: Text(
                "Create Club",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .055,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              )),
          SizedBox(
            height: 30,
          )
        ]),
      ),
    );
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //         title: Text('Register a new club'),
  //       ),
  //       body: Container(
  //         // height: 100,
  //         width: MediaQuery.of(context).size.width,
  //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //         child: Column(children: <Widget>[
  //           const Text(
  //             "Choose Profile photo",
  //             style: TextStyle(fontSize: 20),
  //           ),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               ElevatedButton.icon(
  //                 icon: const Icon(Icons.camera),
  //                 onPressed: _getImageFromGallery,
  //                 label: const Text("Camera"),
  //               ),
  //               ElevatedButton.icon(
  //                 icon: const Icon(Icons.camera),
  //                 onPressed: _getImageFromGallery,
  //                 label: const Text("Gallery"),
  //               )
  //             ],
  //           ),
  //           ElevatedButton.icon(
  //             icon: const Icon(Icons.camera),
  //             onPressed: _uploadImage,
  //             label: const Text("Camera"),
  //           ),
  //         ]),
  // )
  // body: Center(
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       if (_image != null)
  //         Image.file(
  //           _image!,
  //           height: 200,
  //         ),
  //       ElevatedButton(
  //         onPressed: _getImageFromGallery,
  //         child: const Text('Select Image'),
  //       ),
  //       ElevatedButton(
  //         onPressed: _uploadImage,
  //         child: const Text('Upload Image'),
  //       ),
  //     ],
  //   ),
  // ),
  // );
}
// }
