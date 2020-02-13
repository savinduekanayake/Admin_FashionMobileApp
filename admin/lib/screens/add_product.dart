import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();

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
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                      onPressed: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14,40,14,40),
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
                        onPressed: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14,40,14,40),
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
                        onPressed: (){

                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14,40,14,40),
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
          ],
        ),
      ),
    );
  }
}

