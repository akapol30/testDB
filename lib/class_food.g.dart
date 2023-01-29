// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCard _$MyCardFromJson(Map<String, dynamic> json) => MyCard(
      ingredient: (json['ingredient'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      quantity:
          (json['quantity'] as List<dynamic>).map((e) => e as String).toList(),
      uom: (json['uom'] as List<dynamic>).map((e) => e as String).toList(),
      step: (json['step'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MyCardToJson(MyCard instance) => <String, dynamic>{
      'ingredient': instance.ingredient,
      'quantity': instance.quantity,
      'uom': instance.uom,
      'step': instance.step,
    };

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      ingredient: (json['ingredient'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      quantity:
          (json['quantity'] as List<dynamic>).map((e) => e as String).toList(),
      uom: (json['uom'] as List<dynamic>).map((e) => e as String).toList(),
      step: (json['step'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'ingredient': instance.ingredient,
      'quantity': instance.quantity,
      'uom': instance.uom,
      'step': instance.step,
    };
