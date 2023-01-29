// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_food.g.dart';

@JsonSerializable(explicitToJson: true)
class MyCard {
  List<String>? ingredient;
  List<String>? quantity;
  List<String>? uom;
  List<String>? step;

  MyCard(
      {required this.ingredient,
      required this.quantity,
      required this.step,
      required this.uom});

  factory MyCard.fromJson(Map<String, String> json) => _$MyCardFromJson(json);

  Map<String, dynamic> toJson() => _$MyCardToJson(this);
}

@JsonSerializable()
class Food extends MyCard {
  @override
  List<String>? ingredient;
  @override
  List<String>? quantity;
  @override
  List<String>? uom;
  @override
  List<String>? step;
  Food({
    this.ingredient,
    this.quantity,
    this.uom,
    this.step,
  }) : super(ingredient: ingredient, quantity: quantity, uom: uom, step: step);

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> foodtoJson() => _$FoodToJson(this);
  static List<Food> foodList = [];

  static Future<List<Food>> call() async {
    final foodRef =
        FirebaseFirestore.instance.collection('food').withConverter<Food>(
              fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
              toFirestore: (food, _) => food.foodtoJson(),
            );
    try {
      await foodRef.get().then((QuerySnapshot snapshot) => {
            if (foodList.length != snapshot.docs.length)
              {
                snapshot.docs.forEach((doc) {
                  print("test----------------${doc["Bing"]}");
                  print("test----------------${doc["Bq"]}");
                  print("exists----------------${doc.exists}");
                  print("doc----------------${doc.data()}");
                  /*if (doc.exists) {
                   
                    final data = doc.data() as Map<String, dynamic>;

                    foodList.add(Food(
                      ingredient: data["Bing"],
                      quantity: data["Bq"],
                      uom: data["Buom"],
                      step: data["Bstep"],
                    ));
                  }*/
                })
              }
          });
    } catch (e) {
      print(e);
    }
    return foodList;
  }
}
