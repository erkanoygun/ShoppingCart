import 'package:hive/hive.dart';
import 'package:shopping_cart/model/products.dart';

abstract class LocalStrogeServices {

  Future<void> addProduct({required Product product});
  Future<Product?> getProducts({required String id});
  Future<List<Product>> getAllProducts();
  Future removeProducts({required Product product});
  Future updateProducts({required Product product});

  
}

class HiveProductStroge extends LocalStrogeServices {
  late Box<Product> _productsBox;

  HiveProductStroge(){
    _productsBox = Hive.box<Product>('products');
  }

  @override
  Future<void> addProduct({required Product product}) async {
   await _productsBox.put(product.id, product);
    
  }

  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> _allProduct = <Product>[];
    _allProduct = _productsBox.values.toList();
    return _allProduct;
  }

  @override
  Future<Product?> getProducts({required String id}) async {
    if(_productsBox.containsKey(id)){
      return _productsBox.get(id);
    }else{
      return null;
    }
  }

  @override
  Future removeProducts({required Product product}) async {
    product.delete();
  }

  @override
  Future updateProducts({required Product product}) async {
    product.save();
  }
}