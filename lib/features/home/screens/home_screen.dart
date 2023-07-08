import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_project_sat26/features/home/data/home_repository.dart';

// [UI - Logic(API) ]
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

  final listOfImages = [
    'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
    'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
    'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
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
          _sliderWidget(),

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

  // FutureBuilder
  // take from you future -> function get data
  // give you a builder -> build ui

  // Steps to integrate API(Data) with UI
  // 1. [DATA/REPOSITORY] Call API (GET,POST, etc..) -> data
  // 2. [UI] Call  [DATA/REPOSITORY] in FutureBuilder
  // 3. [UI] Handle Snapshot -> access real data
  // 4. [UI] Merge data in Widget

  Widget _sliderWidget() {

    return FutureBuilder(
      future: HomeRepository().getHomeData(),
      builder: (context, snapshot) {
        print('This is a data : ${snapshot.data}');
        print('connection state : ${snapshot.connectionState}');

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final response = snapshot.data as Response;
        final data = response.data;
        final banners = data['data']['banners'] as List;

        print('This is banners : $banners');
        return CarouselSlider(
          options: CarouselOptions(height: 200.0),
          /// first way
          items: List.generate(
            banners.length,
            (index) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.network(banners[index]['image']),
                  );
                },
              );
            },
          ),
          /// second way
          // items: [
          //   'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
          //   'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
          //   'https://5.imimg.com/data5/ANDROID/Default/2021/6/UH/ZG/GC/120280019/img-20210624-wa0351-jpg-500x500.jpg',
          // ].map((item) {
          //   return Builder(
          //     builder: (BuildContext context) {
          //       return Container(
          //         width: MediaQuery.of(context).size.width,
          //         margin: EdgeInsets.symmetric(horizontal: 5.0),
          //         child: Image.network(item),
          //       );
          //     },
          //   );
          // }).toList(),
        );
      }
    );

  }
}
// [    <- StateManagement <-          ]
// [ UI <-        Logic    <- Data(Remote/Local) ]

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
              child: Image.asset(
                data['icon'],
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

// MVVM - Clean Architecture - MVC - MVP - Repository Pattern