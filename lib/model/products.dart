import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'products.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  late String productname;
  @HiveField(2)
  late int quantity;
  @HiveField(3)
  late bool isPurchased;
  @HiveField(4)
  late String quantityType;

  Product(
      {required this.id,
      required this.productname,
      required this.quantity,
      required this.isPurchased,
      required this.quantityType});

  factory Product.create(
      {required String productname,
      required int quantity,
      required String quantityType}) {
    return Product(
        id: const Uuid().v1(),
        productname: productname,
        quantity: quantity,
        isPurchased: false,
        quantityType: quantityType);
  }
}
