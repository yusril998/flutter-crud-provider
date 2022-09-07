import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/model/category_model.dart';
import 'package:crud_mobile_flutter/model/product/product_model.dart';
import 'package:crud_mobile_flutter/screen/component/form_widget.dart';
import 'package:crud_mobile_flutter/screen/component/general_appbar.dart';
import 'package:crud_mobile_flutter/screen/component/loading.dart';
import 'package:crud_mobile_flutter/screen/component/modal_selectimage.dart';
import 'package:crud_mobile_flutter/state/product_state.dart';

class FormProductScreen extends StatefulWidget {
  static const routeName = '/form-product';
  final ProductModel? model;
  final CategoryModel? categoryModel;
  FormProductScreen({Key? key, this.model, this.categoryModel})
      : super(key: key);

  /// scaffoldKey used to open sidebaar drawer

  _FormProductScreenState createState() => _FormProductScreenState();
}

class _FormProductScreenState extends State<FormProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime? date;
  File? file;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    if (widget.model != null) {
      _setDefaultValue();
    }

    super.initState();
  }

  _setDefaultValue() async {
    setState(() {
      title.text = widget.model!.title!;
      slug.text = widget.model!.title!;
      deskripsi.text = widget.model!.title!;
    });
  }

  TextEditingController title = TextEditingController();
  TextEditingController slug = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ProductState>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: GeneralAppbar(
        title: 'Form Product',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalChooseImage(
                    context,
                    onCallback: (p0) {
                      setState(() {
                        file = p0;
                      });
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: file != null
                      ? Image.file(
                          file!,
                          fit: BoxFit.cover,
                          height: 180,
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xfff0f2f7),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 0.01,
                                blurRadius: 2,
                                offset:
                                    Offset(1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 180,
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                ),
              ),
              itemTextField('Title', 'Masukkan Title', title),
              itemTextField('Slug', 'Masukkan SLug', slug),
              itemTextField('Deskripsi', 'Masukkan Deskripsi', deskripsi),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => _submitButton(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.zero,
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green, Colors.greenAccent]),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                      // min sizes for Material buttons
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitButton() async {
    try {
      showLoading(context);
      if (title.text.isEmpty) {
        hideLoading(context);
        Flushbar(
          margin: EdgeInsets.all(24),
          message: 'Title harus di isi',
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
        )..show(context);
        return;
      }
      if (slug.text.isEmpty) {
        hideLoading(context);
        Flushbar(
          margin: EdgeInsets.all(24),
          message: 'Slug harus di isi',
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
        )..show(context);
        return;
      }
      if (deskripsi.text.isEmpty) {
        hideLoading(context);
        Flushbar(
          margin: EdgeInsets.all(24),
          message: 'Deskripsi harus di isi',
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
        )..show(context);
        return;
      }
      var state = Provider.of<ProductState>(context, listen: false);
      var response;
      if (widget.model != null) {
        response = await state.savePostProduct(
          title.text,
          slug.text,
          widget.model!.getCategory!.id.toString(),
          deskripsi.text,
          file,
          oldModel: widget.model,
        );
      } else {
        response = await state.savePostProduct(
          title.text,
          slug.text,
          widget.categoryModel!.id.toString(),
          deskripsi.text,
          file,
        );
      }
      await hideLoading(context);
      if (response! == "1") {
        Navigator.pop(context);
      } else {
        print(response);
        Flushbar(
          margin: EdgeInsets.all(24),
          message: response.toString(),
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(10),
        )..show(context);
        ;
      }
    } catch (e) {
      print(e);
      await hideLoading(context);
      Flushbar(
        margin: EdgeInsets.all(24),
        message: 'Data gagal disimpan',
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
      )..show(context);
    }
  }
}
