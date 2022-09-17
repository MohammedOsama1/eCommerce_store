import 'dart:convert';

import 'package:ecommerce_store/screens/hot.dart';
import 'package:ecommerce_store/widgets/product_model.dart';
import 'package:ecommerce_store/cubit/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../screens/add_product.dart';
import '../screens/categories.dart';
import '../screens/favorites.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<ProductModel> productList = [];

  int currentIndex = 0;
  List<Widget> screens = const [
    HotScreen(),
    CategoryScreen(),
    FavoritesScreen(),
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

  Future getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';

    if (productList.isEmpty) {
      await http.get(Uri.parse(url)).then((value) {
        List data = jsonDecode(value.body);

        for (int i = 0; i < data.length; i++) {
          if (productList.length == 20) {
            break;
          } else {
            productList.add(ProductModel.fromJson(data[i]));
          }
        }
        emit(GetProductSucState());
        print(productList.length);
      });
    }
  }

  Future getAllCategories() async {
    emit(GetCategoriesLoadingState());

    String url = 'https://fakestoreapi.com/products/categories';
    await http.get(Uri.parse(url)).then((value) {
      emit(GetCategoriesSucState());
      List categoriesList = jsonDecode(value.body);
      return categoriesList;
    }).catchError((onError) {
      emit(GetCategoriesErrorState());
    });
  }

  List<ProductModel> categoryList = [];

  Future getCategory(String categoryName) async {
    emit(GetCategoryLoadingState());
    String url = 'https://fakestoreapi.com/products/category/$categoryName';
    await http.get(Uri.parse(url)).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        categoryList.add(ProductModel.fromJson(data[i]));
      }
    }).then((value) {
      emit(GetCategorySucState());
      return categoryList;
    }).catchError((onError) {
      emit(GetCategoryErrorState());
    });
  }

  Future addProduct(ProductModel model) async {
    emit(AddProductLoadingState());
    String url = 'https://fakestoreapi.com/products';
    await http.post(Uri.parse(url), body: {
      "title": model.title,
      "price": model.price,
      "description": model.description,
      "image": model.image,
      "category": model.category
    }).then((value) {
      emit(AddProductSucState());
      print(value.body);
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
}
