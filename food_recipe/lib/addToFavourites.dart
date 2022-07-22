import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addToFavourites(
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
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email.toString())
      .update({
    "favorites": FieldValue.arrayUnion([recipeList])
  });
}
