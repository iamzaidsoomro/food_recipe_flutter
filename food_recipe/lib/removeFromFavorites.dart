import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

removeFromFavourites(
    label, ingredients, source, image, cuisine, nutrition, mealType) {
  var removed = true;
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.email)
      .update({
    'favorites': FieldValue.arrayRemove([
      {
        "label": label,
        "ingredients": ingredients,
        "source": source,
        "image": image,
        "cuisine": cuisine,
        "nutrition": nutrition,
        "mealType": mealType
      }
    ])
  }).onError((error, stackTrace) => removed = false);
  return removed;
}
