import 'dart:convert';

import 'package:ecommerce_store/screens/hot.dart';
import 'package:ecommerce_store/widgets/product_model.dart';
import 'package:ecommerce_store/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../screens/add_product.dart';
import '../screens/categories.dart';
import '../screens/favorites.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HotScreen(),
    const CategoryScreen(),
    const FavoritesScreen(),
    AddProductScreen(),
  ];
  List<BottomNavigationBarItem> bottom = const [
    BottomNavigationBarItem(
        label: 'Hot',
        icon: Icon(
          Icons.hotel_class_sharp,
        )),
    BottomNavigationBarItem(
        label: 'Categories', icon: Icon(Icons.category_outlined)),
    BottomNavigationBarItem(label: 'Favorites', icon: Icon(Icons.favorite)),
    BottomNavigationBarItem(label: 'add', icon: Icon(Icons.add)),
  ];

  void changeNavBar(index) {
    currentIndex = index;
    emit(ChangeNavBarSucState());
  }

  ////////////////////////////////////////////////////

  List<ProductModel> productList = [];

  Future getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';

    await http.get(Uri.parse(url)).then((value) {
      List body = jsonDecode(value.body);
//---------------------------------------------------------
      for (int i = 0; i < body.length; i++) {
        productList.add(ProductModel.fromJson(body[i]));
      }

      emit(GetProductSucState());
    });
  }

  List<ProductModel> productCategoryList = [];

  Future getCategory(String categoryName) async {
    emit(GetCategoryLoadingState());

    String url = 'https://fakestoreapi.com/products/category/$categoryName';

    await http.get(Uri.parse(url)).then((value) {
      List body = jsonDecode(value.body);
      if (productCategoryList.isEmpty) {
        for (int i = 0; i < 6; i++) {
          productCategoryList.add(ProductModel.fromJson(body[i]));
        }
      }

      emit(GetCategorySucState());
    }).catchError((onError) {
      emit(GetCategoryErrorState());
    });
  }

  void clearData() {
    productCategoryList.clear();
  }

  Future addProduct(title, price, description, image, category) async {
    emit(AddProductLoadingState());
    String url = 'https://fakestoreapi.com/products';
    await http.post(Uri.parse(url), body: {
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "category": category
    }).then((value) {
      emit(AddProductSucState());
    }).catchError((onError) {
      emit(AddProductErrorState());
    });
  }

  Future upDateProduct(id, ProductModel model) async {
    emit(UpDateProductLoadingState());
    String url = 'https://fakestoreapi.com/products/$id';
    await http.put(Uri.parse(url), body: {
      "title": model.title,
      "price": model.price,
      "description": model.description,
      "image": model.image,
      "category": model.category
    }).then((value) {
      emit(UpDateProductSucState());
    }).catchError((onError) {
      emit(UpDateProductErrorState());
    });
  }

  List<ProductModel> favList = [];

  void addTOFav(ProductModel) {
    favList.contains(ProductModel)
        ? favList.removeWhere((item) => item == ProductModel)
        : favList.add(ProductModel);
    emit(ChangeFavSucState());
  }
}
