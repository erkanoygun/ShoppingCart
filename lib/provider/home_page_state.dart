import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/main.dart';
import 'package:shopping_cart/model/products.dart';
import 'package:shopping_cart/services/local_stroge_services.dart';

class HomePageState extends ChangeNotifier{
  int _currentIndex = 0;
  int quantity = 1;
  String _dropdownValue = 'dropDownMenuItem1'.tr();
  List<Product> productsList = [];
  final LocalStrogeServices _localStroge = locator<LocalStrogeServices>();
  bool isDataLoading = false;

  

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  String get changeDropdownValue => _dropdownValue;

  set changeDropdownValue(String newValue){
    _dropdownValue = newValue;
    notifyListeners();
  }



  void addQuantity(){
    quantity <= 14 ? quantity++ : null;
    notifyListeners();
  }
  void removeQuantity(){
    quantity >= 2 ? quantity-- : null;
    notifyListeners();
  }



  // --------------------------- Local Stroge ---------------------------------

  Future getAllProductDb() async {
    isDataLoading = true;
    productsList = await _localStroge.getAllProducts();
    isDataLoading = false;
    notifyListeners();
  }

  addProduckts(String productname){
    Product newproduct = Product.create(productname: productname, quantity: quantity,quantityType: _dropdownValue);
    productsList.insert(0,newproduct);
    _localStroge.addProduct(product: newproduct);
  }

  productIsPurshed(/*String selecktProductId*/int index){
    /*final Product selecktProduct = ProductsList.firstWhere((element) => element.id == selecktProductId);
    selecktProduct.isPurchased = !selecktProduct.isPurchased;
    _localStroge.updateProducts(product: selecktProduct);*/
    /*for(Product i in ProductsList){
      if(i.id == id){
        i.isPurchased = !i.isPurchased;
        _localStroge.updateProducts(product: i);
        break;
      }
    }*/
    productsList[index].isPurchased = !productsList[index].isPurchased;
    _localStroge.updateProducts(product: productsList[index]);

    notifyListeners();
  }

  productRemove(Product product){
    _localStroge.removeProducts(product: product);
    notifyListeners();
  }



}