import 'package:flutter/material.dart';
import 'package:new_project_sat26/features/product/screens/product_screen.dart';

import '../data/category_repo.dart';
import '../models/category_item_model.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final int id;

  const CategoryScreen({
    super.key,
    required this.id,
    required this.categoryName,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  dynamic category;
  @override
  void initState() {
    super.initState();
    category = CategoryRepo().getCategoryDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder(
          future: category,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              print(snapshot.data);
              final listOfCategories = (snapshot.data as Map<String, dynamic>)['data']['data'];

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: listOfCategories.length,
                itemBuilder: (_, index) {
                  final product =
                      CategoryItemModel.fromJson(listOfCategories[index]);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product.image,
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            product.name.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return Text('There is no data');
          }),
    );
  }
}
