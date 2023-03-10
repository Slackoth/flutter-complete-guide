import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/providers/product_provider.dart';
import 'package:shop_app/domain/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const String routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlCtrl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>(); // Interacts with the Form state
  ProductProvider _editedProduct = ProductProvider.empty();
  ProductProvider? _initProduct;

  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus) {
      String text = _imageUrlCtrl.text;
        
      if(
        (!text.toLowerCase().startsWith('http') 
        && !text.toLowerCase().startsWith('https'))
        || (!text.toLowerCase().endsWith('.png') 
        && !text.toLowerCase().endsWith('.jpg')
        && !text.toLowerCase().endsWith('.jpeg'))
      ) return;
      
      setState(() {});
    }
  }

  void _saveForm() {
    // Triggers validator handle
    final bool? isValid = _form.currentState?.validate();

    if(isValid != null && !isValid) {
      return;
    }
    // Triggers on save handle
    _form.currentState?.save();
    setState(() { _isLoading = true; });

    final NavigatorState navigator = Navigator.of(context);
    final ProductsProvider provider = Provider.of<ProductsProvider>(context, listen: false);

    if(_initProduct != null) {
      provider.updateProduct(_editedProduct);
    }
    else {
      provider.addProduct(_editedProduct).then((value) {
        setState(() { _isLoading = false; });
        navigator.pop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_isInit) {
      final Object? args = ModalRoute.of(context)?.settings.arguments;

      if(args != null) {
        _initProduct = Provider
          .of<ProductsProvider>(context, listen: false)
          .findById(args as String);
        _imageUrlCtrl.text = _initProduct?.imageUrl ?? '';
      }
    }

    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    // Avoid memory leaks\
    _imageUrlCtrl.dispose();
    _priceFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode focusScope = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: _saveForm, 
            icon: const Icon(Icons.save)
          )
        ],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(key: _form, child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              initialValue: _initProduct?.title,
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                // Focuses price textfield
                focusScope.requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if(value != null) {
                  return value.isEmpty ? 'Please provide a value.' : null;
                }

                return 'Please provide a value.';
              },
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: _initProduct?.id ?? '',
                  isFavorite: _initProduct?.isFavorite ?? false,
                  title: newValue ?? '',
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  price: _editedProduct.price
                );
              },
            ),
            TextFormField(
              initialValue: _initProduct?.price.toString(),
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (value) {
                // Focuses description textfield
                focusScope.requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if(value != null) {
                  if(value.isEmpty) return 'Please provide a value.';
                  
                  final double? price = double.tryParse(value);

                  if(price == null) {
                    return 'Please provide a valid number.';
                  } else if(price <= 0) {
                    return 'Please provide a number greater than 0.';
                  }
                  
                  return null;
                }

                return 'Please provide a value.';
              },
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: _initProduct?.id ?? '',
                  isFavorite: _initProduct?.isFavorite ?? false,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  price: double.tryParse(newValue ?? '0') ?? 0
                );
              },
            ),
            TextFormField(
              initialValue: _initProduct?.description,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if(value != null) {
                  if(value.isEmpty) return 'Please provide a value.';
                  
                  if(value.length < 10) return 'This field must be at least 10 characters.';
                  
                  return null;
                }

                return 'Please provide a value.';
              },
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: _initProduct?.id ?? '',
                  isFavorite: _initProduct?.isFavorite ?? false,
                  title: _editedProduct.title,
                  description: newValue ?? '',
                  imageUrl: _editedProduct.imageUrl,
                  price: _editedProduct.price
                );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
                  child: _imageUrlCtrl.text.isEmpty ? 
                    const Text('Enter a URL') :
                    FittedBox(child: Image.network(_imageUrlCtrl.text, fit: BoxFit.cover)
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlCtrl,
                    focusNode: _imageUrlFocusNode,
                    onEditingComplete: () => setState(() {}),
                    onFieldSubmitted: (value) => _saveForm(),
                    validator: (value) {
                      if(value != null) {
                        if(value.isEmpty) return 'Please provide a value.';
                        
                        if(
                          !value.toLowerCase().startsWith('http') 
                          && !value.toLowerCase().startsWith('https')
                        ) {
                          return 'Please provide a valid URL.';
                        }

                        if(
                          !value.toLowerCase().endsWith('.png') 
                          && !value.toLowerCase().endsWith('.jpg')
                          && !value.toLowerCase().endsWith('.jpeg')
                        ) {
                          return 'Please provide a valid image format.';
                        }
                        
                        return null;
                      }

                      return 'Please provide a value.';
                    },
                    onSaved: (newValue) {
                      _editedProduct = ProductProvider(
                        id: _initProduct?.id ?? '',
                        isFavorite: _initProduct?.isFavorite ?? false,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        imageUrl: newValue ?? '',
                        price: _editedProduct.price
                      );
                    },
                  ),
                ),
            ],)
          ]),
        )),
      ),
    );
  }
}