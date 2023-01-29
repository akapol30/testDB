import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:test6/class.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test6/class_getingtext.dart';
class Adddata extends StatefulWidget {
  const Adddata({super.key});

  @override
  State<Adddata> createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
Foodin myFoodbook = Foodin(images: [], ing: [], quantity: [], uom: [], step: []);

  List<File> images = [];

  static int countIng = 0, countStep = 0;
  final formKey = GlobalKey<FormState>();

  final CollectionReference _tableFoodbook =
      FirebaseFirestore.instance.collection("food");
  final TextEditingController _ingCountTextEditingController =
      TextEditingController();
  final TextEditingController _stepCountTextEditingController =
      TextEditingController();
  List<Ingdata> foodsIng = List.generate(countIng, (index) => Ingdata());
  List<Stepdata> foodsStep = List.generate(countStep, (index) => Stepdata());

  void _saveIngToDataBase() {
    for (int i = 0; i < foodsIng.length; i++) {
      myFoodbook.ing.add(foodsIng[i].ingname!);
      myFoodbook.quantity.add(foodsIng[i].quantity!);
      myFoodbook.uom.add(foodsIng[i].uom!);
    }
  }

  void _saveStepToDataBase() {
    for (int i = 0; i < foodsStep.length; i++) {
      myFoodbook.step.add(foodsStep[i].step!);
    }
  }

  void _onListCountChangeIng(int value) {
    setState(() {
      countIng = value;
      foodsIng = List.generate(
          countIng, (index) => Ingdata(ingname: '', quantity: '', uom: ''));
    });
  }

  void _onListCountChangeStep(int value) {
    setState(() {
      countStep = value;
      foodsStep = List.generate(countStep, (index) => Stepdata(step: ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('test'),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(children: [
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      const Text("จำนวนวัตถุดิบทั้งหมด",
                          style: TextStyle(fontSize: 20, fontFamily: 'Mitr')),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'จำนวน',
                            border: OutlineInputBorder(),
                          ),
                          
                          validator: ((value) {
                            if (countIng > 30) {
                              return 'ใส่ได้ <= 30';
                            }
                            return null;
                          }),
                          onChanged: (value) {
                            try {
                              _onListCountChangeIng(int.parse(value));
                            } catch (e) {
                              _onListCountChangeIng(0);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Container(
                              color: Colors.yellow.shade100,
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ListView.builder(
                                  itemCount: countIng,
                                  itemBuilder: (context, index) {
                                    return _multiIng(index);
                                  }))),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    const SizedBox(width: 40),
                    const Text("จำนวนขั้นตอนทั้งหมด",
                        style: TextStyle(fontSize: 20, fontFamily: 'Mitr')),
                    const SizedBox(width: 15),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'จำนวน',
                            border: OutlineInputBorder(),
                          ),
                          validator: ((value) {
                            if (countStep > 20) {
                              return 'ใส่ได้ <= 20';
                            }
                            return null;
                          }),
                          onChanged: (value) {
                            try {
                              _onListCountChangeStep(int.parse(value));
                            } catch (e) {
                              _onListCountChangeStep(0);
                            }
                          },
                        )),
                    const SizedBox(width: 20),
                  ]),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Container(
                              color: Colors.orange.shade100,
                              height: 130,
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: ListView.builder(
                                  itemCount: countStep,
                                  itemBuilder: (context, index) {
                                    return _multiStep(index);
                                  }))),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        _saveIngToDataBase();
                        _saveStepToDataBase();
                        await _tableFoodbook.add({
                          "Bing": myFoodbook.ing,
                          "Bq": myFoodbook.quantity,
                          "Buom": myFoodbook.uom,
                          "Bstep": myFoodbook.step,
                        });
                        formKey.currentState?.reset();
                      }

                      //Navigator.pop(context);
                    },
                    child: const Text('ยืนยันคำขอ',
                        style: TextStyle(fontFamily: 'Mitr')),
                  ),
                ]))));
  }

  _multiStep(int index) {
    return Row(children: [
      Text("${index + 1}", style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 10),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'ขั้นตอน',
              border: OutlineInputBorder(),
            ),
            initialValue: foodsStep[index].step,
            validator: RequiredValidator(errorText: "กรุณาป้อนขั้นตอนการทำ ^^"),
            onChanged: (v) {
              foodsStep[index].step = v;
            },
          ))
    ]);
  }

  _multiIng(int index) {
    return Row(
      children: [
        Text(
          "${index + 1}",
          style: const TextStyle(fontSize: 18),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.only(left: 12),
                width: MediaQuery.of(context).size.width * 0.28,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'วัตถุดิบ',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: foodsIng[index].ingname,
                  validator:
                      RequiredValidator(errorText: "กรุณาป้อนชื่อวัตถุดิบ ^^"),
                  onChanged: (v) {
                    foodsIng[index].ingname = v;
                  },
                ))),
        const SizedBox(width: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'จำนวน',
                border: OutlineInputBorder(),
              ),
              initialValue: foodsIng[index].quantity,
              validator:
                  RequiredValidator(errorText: "กรุณาป้อนจำนวนวัตถุดิบ ^^"),
              onChanged: (c) {
                foodsIng[index].quantity = c;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            )),
        const SizedBox(width: 15),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding: const EdgeInsets.only(right: 20),
                width: MediaQuery.of(context).size.width * 0.30,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'หน่วย',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: foodsIng[index].uom,
                  validator:
                      RequiredValidator(errorText: "กรุณาป้อนหน่วยวัตถุดิบ ^^"),
                  onChanged: (v) {
                    foodsIng[index].uom = v;
                  },
                ))),
      ],
    );
  }
}
