import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();
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
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14,70,14,70),
                          child: Icon(Icons.add, color: grey,),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14,70,14,70),
                            child: Icon(Icons.add, color: grey,),
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14,70,14,70),
                            child: Icon(Icons.add, color: grey,),
                          )
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
                  controller: ProductNameController,
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
                  Checkbox(value: selectedSizes.contains('XS'), onChanged: changeSelectedSize),
                  Text('XS'),

                  Checkbox(value: false, onChanged: null),
                  Text('S'),

                  Checkbox(value: false, onChanged: null),
                  Text('M'),

                  Checkbox(value: false, onChanged: null),
                  Text('L'),

                  Checkbox(value: false, onChanged: null),
                  Text('XL'),

                  Checkbox(value: false, onChanged: null),
                  Text('XXL'),

                ],
              ),

              Text('Available sizes'),
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: null),
                  Text('28'),

                  Checkbox(value: false, onChanged: null),
                  Text('30'),

                  Checkbox(value: false, onChanged: null),
                  Text('32'),

                  Checkbox(value: false, onChanged: null),
                  Text('34'),

                  Checkbox(value: false, onChanged: null),
                  Text('36'),

                  Checkbox(value: false, onChanged: null),
                  Text('38'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: false, onChanged: null),
                  Text('40'),

                  Checkbox(value: false, onChanged: null),
                  Text('42'),

                  Checkbox(value: false, onChanged: null),
                  Text('44'),

                  Checkbox(value: false, onChanged: null),
                  Text('46'),

                  Checkbox(value: false, onChanged: null),
                  Text('48'),

                  Checkbox(value: false, onChanged: null),
                  Text('50'),
                ],
              ),
          // Button
              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: (){},
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

  void changeSelectedSize(bool size) {

  }
}

