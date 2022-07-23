import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

addToFavourites(
    label, ingredients, source, image, cuisine, nutrition, mealType) {
  var recipeList = {
    "label": label,
    "ingredients": ingredients,
    "source": source,
    "image": image,
    "cuisine": cuisine,
    "nutrition": nutrition,
    "mealType": mealType
  };
  var added = true;
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email.toString())
      .update({
    "favorites": FieldValue.arrayUnion([recipeList])
  }).onError((error, stackTrace) => added = false);
  return added;
}
