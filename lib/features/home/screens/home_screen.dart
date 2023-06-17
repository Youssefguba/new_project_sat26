import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final listOfCategories = [
    {
      'icon': 'assets/images/shirt.png',
      'text': 'Shirts',
    },
    {
      'icon': 'assets/images/dress.png',
      'text': 'Dresses',
    },
    {
      'icon': 'assets/images/man_bag.png',
      'text': 'Man Work Equipment',
    },
    {
      'icon': 'assets/images/shirt.png',
      'text': 'Equipments',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          // Slider

          // Category
          /// 2 ways to do a for loop with Widgets :

          /// first way
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // for (var i = 0; i < listOfCategories.length; i++)
                //   CategoryItemWidget(
                //     data: listOfCategories[i],
                //   ),
              ],
            ),
          ),
          SizedBox(height: 10),

          /// second way
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: List.generate(50, (i) => CategoryItemWidget(i: i)),
          //   ),
          // ),

          Container(
            height: 120,
            child: ListView.builder(
              itemCount: listOfCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryItemWidget(
                  data: listOfCategories[index],
                );
              },
            ),
          ),

          // Flash Sale
        ],
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFFEBF0FF),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Image.asset(data['icon'],
              height: 25,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 75,
          child: Text(
            data['text'],
            maxLines: 2,
            textAlign: TextAlign.center,


          ),
        ),
      ],
    );
  }
}
