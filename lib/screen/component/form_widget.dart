import 'package:flutter/material.dart';

Widget itemTextField(
    String title, String? hinttext, TextEditingController? controller,
    {bool withLabel = true,
    bool isSearch = false,
    Function(String)? onChanged}) {
  return ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      if (withLabel)
        SizedBox(
          height: 20,
        ),
      if (withLabel)
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      if (withLabel)
        SizedBox(
          height: 10,
        ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xfff0f2f7),
          border: Border.all(color: Colors.grey.shade400, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0.01,
              blurRadius: 2,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: TextFormField(
            // initialValue: _initValues['title'],
            controller: controller,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide a value.';
              }
              return null;
            },
          ),
        ),
      ),
    ],
  );
}
