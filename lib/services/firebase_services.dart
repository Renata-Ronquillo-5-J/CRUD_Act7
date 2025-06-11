import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getpeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection("people");
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "id": data['id'], // Agregado el campo 'id'
      "name": data['name'],
      "age": data['age'], // Agregado el campo 'age'
      "phone": data['phone'], // Agregado el campo 'phone'
      "email": data['email'], // Agregado el campo 'email'
      "address": data['address'], // Agregado el campo 'address'
      "paymentMethod":
          data['paymentMethod'], // Agregado el campo 'paymentMethod'
      "uid": doc.id,
    };
    people.add(person);
  }
  return people;
}

// Guardar un nuevo registro en base de datos con múltiples campos
Future<void> addpeople(
  String id,
  String name,
  int age,
  String phone,
  String email,
  String address,
  String paymentMethod,
) async {
  await db.collection("people").add({
    "id": id,
    "name": name,
    "age": age,
    "phone": phone,
    "email": email,
    "address": address,
    "paymentMethod": paymentMethod,
  });
}

//Actualizar un registro en base de datos con múltiples campos
Future<void> updatepeople(
  String uid,
  String newId,
  String newName,
  int newAge,
  String newPhone,
  String newEmail,
  String newAddress,
  String newPaymentMethod,
) async {
  await db.collection("people").doc(uid).set({
    "id": newId,
    "name": newName,
    "age": newAge,
    "phone": newPhone,
    "email": newEmail,
    "address": newAddress,
    "paymentMethod": newPaymentMethod,
  });
}

// Borrar datos de la base de datos
Future<void> deletepeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}
