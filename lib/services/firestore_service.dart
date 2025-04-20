import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a collection reference
  CollectionReference getCollection(String collectionName) {
    return _firestore.collection(collectionName);
  }

  // Add a document to a collection
  Future<void> addDocument(
      String collectionName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      throw Exception('Error adding document: $e');
    }
  }

  // Update a document
  Future<void> updateDocument(
      String collectionName, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(docId).update(data);
    } catch (e) {
      throw Exception('Error updating document: $e');
    }
  }

  // Delete a document
  Future<void> deleteDocument(String collectionName, String docId) async {
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  // Get a document by ID
  Future<DocumentSnapshot> getDocument(
      String collectionName, String docId) async {
    try {
      return await _firestore.collection(collectionName).doc(docId).get();
    } catch (e) {
      throw Exception('Error getting document: $e');
    }
  }

  // Get all documents from a collection
  Stream<QuerySnapshot> getDocuments(String collectionName) {
    return _firestore.collection(collectionName).snapshots();
  }

  // Query documents with conditions
  Stream<QuerySnapshot> queryDocuments(
    String collectionName, {
    String? field,
    dynamic isEqualTo,
    dynamic isGreaterThan,
    dynamic isLessThan,
  }) {
    Query query = _firestore.collection(collectionName);

    if (field != null && isEqualTo != null) {
      query = query.where(field, isEqualTo: isEqualTo);
    }
    if (field != null && isGreaterThan != null) {
      query = query.where(field, isGreaterThan: isGreaterThan);
    }
    if (field != null && isLessThan != null) {
      query = query.where(field, isLessThan: isLessThan);
    }

    return query.snapshots();
  }
}
