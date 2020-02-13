import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
class BrandService{
  Firestore _firestore = Firestore.instance;
  String ref = 'brands';

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection('brands').document(brandId).setData({'brand': name});
  }

  Future<List> getBrand(){
    Stream<QuerySnapshot> snapshots = _firestore.collection(ref).snapshots();

    List brands;
//    snapshots.forEach((snap){
//      brands = snap.documents[];
//      brands.insert(0, snap.documents)
//    });
  }
}