import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/custom_text_field.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final _title = TextEditingController();
  final _descr = TextEditingController();
  final _date = TextEditingController();
  final _phn = TextEditingController();
  final _userName = TextEditingController();
  final _address = TextEditingController();
  final _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppProductPage'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        children: [
          CustomTextField(
            controller: _title,
            hintText: 'Title',
            validator: (value) {},
          ),
          CustomTextField(
            controller: _descr,
            hintText: 'Description',
            validator: (value) {},
          ),
          CustomTextField(
            controller: _date,
            hintText: 'DateTime',
            onTap: () {
              showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    height:
                        MediaQuery.of(context).copyWith().size.height * 0.25,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        _date.text = value.toString();
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: 2000,
                      maximumYear: 3000,
                    ),
                  );
                },
              );
            },
            validator: (value) {},
          ),
          CustomTextField(
            controller: _phn,
            hintText: 'Phone number',
            validator: (value) {},
          ),
          CustomTextField(
            controller: _userName,
            hintText: 'User name',
            validator: (value) {},
          ),
          CustomTextField(
            controller: _address,
            hintText: 'Address',
            validator: (value) {},
          ),
          CustomTextField(
            controller: _price,
            hintText: 'Price',
            validator: (value) {},
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.publish),
            label: const Text('Add to FireStore'),
          ),
        ],
      ),
    );
  }
}
