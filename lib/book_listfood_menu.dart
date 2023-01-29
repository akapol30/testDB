import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test6/class_food.dart';

class BookListFoodMenu extends StatefulWidget {
  const BookListFoodMenu({Key? key}) : super(key: key);

  @override
  State<BookListFoodMenu> createState() => _BookListFoodMenuState();
}

class _BookListFoodMenuState extends State<BookListFoodMenu> {
  Widget dataFoodPopular() {
    return FutureBuilder(
        future: Food.call(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.only(bottom: 10),
            height: 315,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Food.foodList.length,
              itemBuilder: (context, index) {
                final food = Food.foodList[index];
                return GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailFood(food: food);
                        },
                      ),
                    );*/
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 15, left: 0),
                    width: 225,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xffFBCEDC),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(food.ingredient![0]),
                              //child: Image.network(
                              // food.pic[0],
                              // width: 150,
                              // height: 130,
                              // ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  String dropdownValue = 'TH';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              //Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (BuildContext context) => MyApp()));
            },
          ),
          Align(
              alignment: Alignment.center,
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['TH', 'EN', 'CN', 'TW']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        ],
        title:
            const Text("อาหารภาคเหนือ", style: TextStyle(fontFamily: 'Mitr')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('')],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mitr',
                      ),
                    ),
                  ],
                ),
              ),
              dataFoodPopular(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "New in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mitr',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Color(0xffFF5F99)),
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Mitr',
                              color: Color(0xffFF5F99),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavB extends StatefulWidget {
  const FavB({Key? key}) : super(key: key);

  @override
  State<FavB> createState() => _FavBState();
}

class _FavBState extends State<FavB> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFav = !isFav;
        });
      },
      icon: Icon(
        isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: const Color(0xffFF5F99),
        size: 24.0,
      ),
    );
  }
}
