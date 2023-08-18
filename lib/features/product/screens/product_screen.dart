import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/product_cubit.dart';

class ProductScreen extends StatefulWidget {
  final int productId;

  const ProductScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool? videoCall;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProduct(widget.productId);
  }

  @override
  void didUpdateWidget(covariant ProductScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    videoCall = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if(state is ProductSuccessful) {

          return Scaffold(
            appBar: AppBar(
              title: Text(state.product.name),
            ),
            body: ListView(
              children: [
                // CarouselSlider(items: (), options: options)

                Text(
                  state.product.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff223263),
                  ),
                ),

                Text(
                  '${state.product.price} EGP',
                  style: TextStyle(
                    color: Color(0xff40BFFF),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        if(state is LoadingProduct) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if(state is ProductFailed) {
          return Scaffold(
            body: Center(child: Text('Error try again!')),
          );
        }

        if(state is ProductNoInternetConnection) {
          return Scaffold(
            body: Center(child: Text('No Internet Connection!')),
          );
        }

        return const SizedBox();
      },
    );
  }
}
