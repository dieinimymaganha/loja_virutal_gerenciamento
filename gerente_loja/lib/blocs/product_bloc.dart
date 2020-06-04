import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();

  Stream<Map> get outData => _dataController;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsaveData;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsaveData = Map.of(product.data);
      unsaveData['images'] = List.of(product.data['images']);
      unsaveData['images'] = List.of(product.data['size']);
    }else{
      unsaveData = {
        'title' : null,
        'description': null,
        'price' : null,
        'images': [],
        'size': [],
      };
    }
    _dataController.add(unsaveData);
  }

  @override
  void dispose() {
    _dataController.close();
  }
}
