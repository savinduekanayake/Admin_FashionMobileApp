//import 'dart:html';
//import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart'; // suggestion the words
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];

  List<DropdownMenuItem<String>> catergoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCatergory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  List<String> selectedSizes = <String>[];

  File _image1;
  File _image2;
  File _image3;

  @override
  void initState(){
    _getCatergories();
    _getBrands();


//    _currentCatergory = catergoriesDropDown[0].value;
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown(){
    List<DropdownMenuItem<String>> items = new List();
    for(int i =0; i< categories.length; i++){
      setState(() {
        items.insert(0, DropdownMenuItem(child: Text(categories[i].data['category']),
          value: categories[i].data['category'],));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBandsDropDown(){
    List<DropdownMenuItem<String>> items = new List();
    for(int i =0; i< brands.length; i++){
      setState(() {
        items.insert(0, DropdownMenuItem(child: Text(brands[i].data['brand']),
          value: brands[i].data['brand'],));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(Icons.close, color: black,),
        title: Text('add product',style: TextStyle(color: black)),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: (){
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),1);
                        },
                        child: _displayChild1()
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),2);
                          },
                          child:_displayChild2()
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),3);

                          },
                          child: _displayChild3()
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Enter a product name with 10 characters maximum", textAlign: TextAlign.center ,style: TextStyle(color: red, fontSize: 12),),
              ),
              
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: ProductNameController,
                  decoration: InputDecoration(
                    hintText: 'Product name'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'You must enther the product name';
                    }else if(value .length>10){
                      return 'Product name cant have more than 10 tetters';
                    }
                  },
                ),
              ),

            Row(
                children: <Widget>[
                  // select category
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Category: ', style: TextStyle(color: red),),
                  ),
                  DropdownButton(items: catergoriesDropDown, onChanged: changeSelectedCategory, value: _currentCatergory,),

                  // select brand
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Brand: ', style: TextStyle(color: red),),
                  ),
                  DropdownButton(items: brandsDropDown, onChanged: changeSelectedBrand, value: _currentBrand,),
                ]
            ),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Quantity'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'You must enther the product name';
                    }
                  },
                ),
              ),

              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('XS'), onChanged: (value)=>changeSelectedSize('XS')),
                  Text('XS'),

                  Checkbox(value: selectedSizes.contains('S'), onChanged: (value)=>changeSelectedSize('S')),
                  Text('S'),

                  Checkbox(value: selectedSizes.contains('M'), onChanged: (value)=>changeSelectedSize('M')),
                  Text('M'),

                  Checkbox(value: selectedSizes.contains('L'), onChanged: (value)=>changeSelectedSize('L')),
                  Text('L'),

                  Checkbox(value: selectedSizes.contains('XL'), onChanged: (value)=>changeSelectedSize('XL')),
                  Text('XL'),

                  Checkbox(value: selectedSizes.contains('XXL'), onChanged: (value)=>changeSelectedSize('XXL')),
                  Text('XXL'),

                ],
              ),

              Text('Available sizes'),
              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('28'), onChanged: (value)=>changeSelectedSize('28')),
                  Text('28'),

                  Checkbox(value: selectedSizes.contains('30'), onChanged: (value)=>changeSelectedSize('30')),
                  Text('30'),

                  Checkbox(value: selectedSizes.contains('32'), onChanged: (value)=>changeSelectedSize('32')),
                  Text('32'),

                  Checkbox(value: selectedSizes.contains('34'), onChanged: (value)=>changeSelectedSize('34')),
                  Text('34'),

                  Checkbox(value: selectedSizes.contains('36'), onChanged: (value)=>changeSelectedSize('36')),
                  Text('36'),

                  Checkbox(value: selectedSizes.contains('38'), onChanged: (value)=>changeSelectedSize('38')),
                  Text('38'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('40'), onChanged: (value)=>changeSelectedSize('40')),
                  Text('40'),

                  Checkbox(value: selectedSizes.contains('42'), onChanged: (value)=>changeSelectedSize('42')),
                  Text('42'),

                  Checkbox(value: selectedSizes.contains('44'), onChanged: (value)=>changeSelectedSize('44')),
                  Text('44'),

                  Checkbox(value: selectedSizes.contains('46'), onChanged: (value)=>changeSelectedSize('46')),
                  Text('46'),

                  Checkbox(value: selectedSizes.contains('48'), onChanged: (value)=>changeSelectedSize('48')),
                  Text('48'),

                  Checkbox(value: selectedSizes.contains('50'), onChanged: (value)=>changeSelectedSize('50')),
                  Text('50'),
                ],
              ),
          // Button
              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: (){
                  validateAndUpload();
                },
              )

            ],
          ),
        ),
      ),
    );
  }

   _getCatergories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      catergoriesDropDown = getCategoriesDropDown();
      _currentCatergory = categories[0].data['category'];
      print(_currentCatergory);
    });
  }

  _getBrands() async{
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBandsDropDown();
      _currentBrand = brands[0].data['brand'];
      print(_currentBrand);
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(()=>_currentCatergory=selectedCategory);
  }

  changeSelectedBrand(String selectedbrand) {
    setState(()=>_currentBrand=selectedbrand);
  }

  void changeSelectedSize(String size) {
    if(selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
    }else{
      setState(() {
        selectedSizes.insert(0,size);
      });

    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1: setState(() => _image1=tempImg);
      break;
      case 2: setState(() => _image2=tempImg);
      break;
      case 3: setState(() => _image3=tempImg);
      break;
    }

  }

  Widget _displayChild1() {
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14,70,14,70),
        child: Icon(Icons.add, color: grey,),
      );
    }else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity ,);

    }
  }


Widget _displayChild2() {
  if(_image2 == null){
    return Padding(
      padding: const EdgeInsets.fromLTRB(14,70,14,70),
      child: Icon(Icons.add, color: grey,),
    );
  }else{
    return Image.file(_image2 ,fit: BoxFit.fill, width: double.infinity );

  }
}


Widget _displayChild3() {
  if(_image3 == null){
    return Padding(
      padding: const EdgeInsets.fromLTRB(14,70,14,70),
      child: Icon(Icons.add, color: grey,),
    );
  }else{
    return Image.file(_image3, fit: BoxFit.fill, width: double.infinity );

  }
}

  void validateAndUpload() {
    if(_formKey.currentState.validate()){
      if(_image1 != null && _image2 != null && _image3 != null){
        if(selectedSizes.isNotEmpty){
          String imageUrl;
          final String picture = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
//          StorageUploadTask task = storage.ref()
        }else{
          Fluttertoast.showToast(msg: 'select atleast one size');
        }
      }else{
        Fluttertoast.showToast(msg: 'All the images must be provided');
      }
    }
  }
}

