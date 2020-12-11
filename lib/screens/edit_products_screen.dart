import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stateManagement/providers/products_provider.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isinit = true;
  var _isLoading = false;
  var _initialState = {
    'id': null,
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
    "isFavorite": false
  };

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final productId = ModalRoute.of(context).settings.arguments;
    print(productId);
    if (_isinit) {
      if (productId != null) {
        final _editedProduct =
            Provider.of<Products>(context).finstById(productId);
        // print(_editedProduct.id);
        _initialState["id"] = _editedProduct.id;
        _initialState["title"] = _editedProduct.title;
        _initialState["price"] = _editedProduct.price.toString();
        _initialState["description"] = _editedProduct.description;
        _initialState["imageUrl"] = "";
        _initialState["isFavorite"] = _editedProduct.isFavorite;
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isinit = false;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    _imageURLFocusNode.addListener((_updateImageUrl));
    super.initState();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener((_updateImageUrl));
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageURLFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageURLFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    print("helo ad ");
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    // return;
    final newProduct = Product(
      id: _initialState["id"],
      title: _initialState["title"],
      description: _initialState["description"],
      price: double.parse(_initialState["price"]),
      imageUrl: _initialState["imageUrl"],
      isFavorite: _initialState["isFavorite"],
    );

    if (_initialState["id"] == null) {
      Provider.of<Products>(context, listen: false)
          .addProduct(newProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_initialState["id"], newProduct);
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    }

    // print(title);
    // print(price);
    // print(description);
    // print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    //..
                    TextFormField(
                      initialValue: _initialState["title"],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter value Please";
                        }
                      },
                      onSaved: (value) {
                        _initialState["title"] = value;
                      },
                    ),
                    TextFormField(
                      initialValue: _initialState["price"],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter price";
                        }
                        if (double.tryParse(value) == null) {
                          return "please enter valid number";
                        }
                        if (double.parse(value) <= 1) {
                          return "Please enter a number greater than one";
                        }
                      },
                      onSaved: (value) {
                        _initialState["price"] = (value);
                        // _editedProduct = Product(
                        //     id: null,
                        //     title: _editedProduct.title,
                        //     price: double.parse(value),
                        //     description: _editedProduct.description,
                        //     imageUrl: _editedProduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initialState["description"],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _initialState["description"] = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter description";
                        }
                        if (value.length < 5) {
                          return "Please enter More than 5 words";
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("enter a url")
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "image Url"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageURLFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter url";
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'please enter valid url';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return "Please enter a valid image url";
                              }
                            },
                            onSaved: (value) {
                              _initialState["imageUrl"] = value;
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
