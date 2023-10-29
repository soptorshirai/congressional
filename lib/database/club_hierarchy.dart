import 'package:cloud_firestore/cloud_firestore.dart';

// class Club {
//   final String id;
//   final String name;

//   Club({required this.id, required this.name});

//   // Convert Firestore document snapshot to Club object
//   factory Club.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return Club(
//       id: snapshot.id,
//       name: data['name'],
//     );
//   }
// }

// class School {
//   final String id;
//   final String name;

//   School({required this.id, required this.name});

//   // Convert Firestore document snapshot to School object
//   factory School.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return School(
//       id: snapshot.id,
//       name: data['name'],
//     );
//   }
// }
class School {
  final String name;
  final String state;
  final String district;
  final String stateID;
  // Add more fields as needed

  School({
    required this.name,
    required this.state,
    required this.district,
    required this.stateID,
    // Initialize additional fields here
  });
}

class Club {
  final String clubName;
  final String clubDescription;
  final String imageURL;
  final String contact;
  final String link;
  // Add more fields as needed

  Club(
      {required this.clubName,
      required this.clubDescription,
      required this.imageURL,
      required this.link,
      required this.contact
      // Initialize additional fields here
      });
}

class District {
  final String name;

  District({required this.name});

  // Convert Firestore document snapshot to District object
  factory District.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return District(
      name: data['name'],
    );
  }
}

class States {
  final String id;
  final String name;

  States({required this.id, required this.name});

  // @override
  // bool operator ==(other) {
  //   return other is States && id == other.id;
  // }

  // @override
  // int get hashCode => id.hashCode;

  // Convert Firestore document snapshot to States object
  String getName() {
    return name;
  }

  String getID() {
    return id;
  }

  factory States.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return States(
      id: snapshot.id,
      name: data['name'],
    );
  }
}

class ClubService {
  final CollectionReference statesCollection =
      FirebaseFirestore.instance.collection('states');

  Future<List<States>> getStates() async {
    final snapshot = await statesCollection.get();
    return snapshot.docs.map((doc) => States.fromSnapshot(doc)).toList();
  }

  Future<List<District>> getDistricts(String stateId) async {
    final snapshot =
        await statesCollection.doc(stateId).collection('districts').get();
    return snapshot.docs.map((doc) => District.fromSnapshot(doc)).toList();
  }

  // Future<List<School>> getSchools(String stateId, String districtId) async {
  //   final snapshot = await statesCollection
  //       .doc(stateId)
  //       .collection('districts')
  //       .doc(districtId)
  //       .collection('schools')
  //       .get();
  //   return snapshot.docs.map((doc) => School.fromSnapshot(doc)).toList();
  // }

  // Future<List<Club>> getClubs(
  //     String stateId, String districtId, String schoolId) async {
  //   final snapshot = await statesCollection
  //       .doc(stateId)
  //       .collection('districts')
  //       .doc(districtId)
  //       .collection('schools')
  //       .doc(schoolId)
  //       .collection('clubs')
  //       .get();
  //   return snapshot.docs.map((doc) => Club.fromSnapshot(doc)).toList();
  // }
}
