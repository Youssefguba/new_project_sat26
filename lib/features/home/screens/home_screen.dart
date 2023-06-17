import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < 50; i++) CategoryItemWidget(i: i),
              ],
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(50, (i) => CategoryItemWidget(i: i)),
            ),
          ),

          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryItemWidget(i: index);
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
  final int i;
  const CategoryItemWidget({
    super.key,
    required this.i,
  });

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
              child: Icon(
                Icons.person,
                color: Color(0xff40BFFF),
              ),
            ),
          ),
        ),
        Text('Shirts + ${i + 1}'),
      ],
    );
  }
}
