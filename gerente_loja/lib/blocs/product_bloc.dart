import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController;

  Stream<bool> get outLoading => _loadingController;
  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsaveData;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsaveData = Map.of(product.data);
      unsaveData['images'] = List.of(product.data['images']);
      unsaveData['size'] = List.of(product.data['size']);
    } else {
      unsaveData = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'size': [],
      };
    }
    _dataController.add(unsaveData);
  }

  void saveTitle(String title) {
    unsaveData['title'] = title;
  }

  void saveDescription(String description) {
    unsaveData['description'] = description;
  }

  void savePrice(String price) {
    unsaveData['price'] = double.parse(price);
  }

  void saveImages(List images) {
    unsaveData['images'] = images;
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    await Future.delayed(Duration(seconds: 3));
    _loadingController.add(false);
    return true;
  }
}
