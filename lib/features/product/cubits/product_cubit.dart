import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_project_sat26/features/product/data/product_repo.dart';
import 'package:new_project_sat26/features/product/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void getProduct(int id) async {
    try {
      emit(LoadingProduct());
      final product = await ProductRepo().getProductById(id);
      if(product != null) {
        emit(ProductSuccessful(product));
      }
    } on SocketException catch (e) {
      emit(ProductNoInternetConnection());
    } on Exception catch(e) {
      emit(ProductFailed());
    } catch(e) {
      emit(ProductFailed());
    }
  }
}
