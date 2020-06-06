import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController;

  Stream<bool> get outLoading => _loadingController;

  Stream<bool> get outCreated => _createController;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsaveData;

  ProductBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsaveData = Map.of(product.data);
      unsaveData['images'] = List.of(product.data['images']);
      unsaveData['size'] = List.of(product.data['size']);
      _createController.add(true);
    } else {
      unsaveData = {
        'title': null,
        'description': null,
        'price': null,
        'images': [],
        'size': [],
      };
      _createController.add(false);
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
    _createController.close();
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      if (product != null) {
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsaveData);
        _createController.add(true);
      } else {
        DocumentReference dr = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("items")
            .add(Map.from(unsaveData)..remove("images"));
        await _uploadImages(dr.documentID);
        await dr.updateData(unsaveData);
      }
      _createController.add(true);
      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsaveData["images"].length; i++) {
      if (unsaveData["images"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsaveData["images"][i]);

      StorageTaskSnapshot s = await uploadTask.onComplete;
      String downloadUrl = await s.ref.getDownloadURL();

      unsaveData["images"][i] = downloadUrl;
    }
  }

  void deleteProduct() {
    product.reference.delete();
  }
}
