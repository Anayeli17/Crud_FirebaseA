import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  // CollectionReference collectionReferencePeople = db.collection('people');

  //QuerySnapshot queryPeople = await collectionReferencePeople.get();
  QuerySnapshot querySnapshot = await db.collection('people').get();

  // queryPeople.docs.forEach((documento) {
  //   people.add(documento.data());
  // });

  //await Future.delayed(const Duration(seconds: 5));

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {"name": data['name'], "uid": doc.id};

    people.add(person);
  }

  return people;
}

Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

Future<void> updatePeople(String uid, String newNme) async {
  await db.collection("people").doc(uid).set({"name": newNme});
}

Future<void> deletePeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}
