import 'package:animal_collectables/models/collectable_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

CollectionReference<Map<String, dynamic>> cardsCollection =
    db.collection('collectable_cards');

Future<DocumentReference<Map<String, dynamic>>?> addNewCard(
    CollectableCardModel card, String uuid) async {
  final CollectableCardFirebaseModel cardForFirebase =
      CollectableCardFirebaseModel(
    userId: uuid,
    commonName: card.commonName,
    scientificName: card.scientificName,
    habitat: card.habitat,
    weight: card.weight,
    sex: card.sex,
    curiousInformation: card.curiousInformation,
    // createdAt: FieldValue.serverTimestamp(),
    // updatedAt: FieldValue.serverTimestamp(),
  );
  final DocumentReference<Map<String, dynamic>> res = await cardsCollection.add(
    cardForFirebase.toFirebaseJson(),
  );

  return res;
  // ;
}

Future<int> getStatsOfCard(String scientificName) async {
  final res = await cardsCollection
      .where("scientific_name", isEqualTo: scientificName)
      .orderBy("image_url")
      .get();
  return res.size;
}

Future<DocumentReference<Map<String, dynamic>>> getCard(
    String reference) async {
  return cardsCollection.doc(reference);
}

Future<void> deleteCard(String reference) async {
  await cardsCollection.doc(reference).delete();
}

Future<CollectableCardFirebaseModel?> getExistingCard(
    String scientificName, String uuid) async {
  final res = await cardsCollection
      .where("scientific_name", isEqualTo: scientificName)
      .where("user_id", isEqualTo: uuid)
      .orderBy("image_url")
      .get()
      .then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        return docSnapshot;
      }
    },
    onError: (e) => throw Exception(e),
  );
  if (res != null) {
    return CollectableCardFirebaseModel.fromJson(res.data(), res.id);
  }
  return null;
}

Future<List<CollectableCardFirebaseModel>> getUserCards(String uuid) async {
  try {
    final res = await cardsCollection
        .where("user_id", isEqualTo: uuid)
        .orderBy("image_url")
        .get();
    return res.docs
        .map((e) => CollectableCardFirebaseModel.fromJson(e.data(), e.id))
        .toList();
  } catch (e) {
    return [];
  }
}
