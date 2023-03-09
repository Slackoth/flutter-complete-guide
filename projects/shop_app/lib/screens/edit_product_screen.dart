import 'package:flutter/material.dart';
import 'package:shop_app/domain/providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const String routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlCtrl = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>(); // Interacts with the Form state
  ProductProvider _editedProduct = ProductProvider.empty();

  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    // Allows to take all textfield values
    _form.currentState?.save();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(key: _form, child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                // Focuses price textfield
                focusScope.requestFocus(_priceFocusNode);
              },
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: '',
                  title: newValue ?? '',
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  price: _editedProduct.price
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (value) {
                // Focuses description textfield
                focusScope.requestFocus(_descriptionFocusNode);
              },
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: '',
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  price: double.tryParse(newValue ?? '0') ?? 0
                );
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                _editedProduct = ProductProvider(
                  id: '',
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
                    onSaved: (newValue) {
                      _editedProduct = ProductProvider(
                        id: '',
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