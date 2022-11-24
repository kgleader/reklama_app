import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reklama_app/add_product/services/date_time_service.dart';
import 'package:reklama_app/add_product/services/image_picker_service.dart';

import 'package:reklama_app/components/custom_text_field.dart';

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
          const SizedBox(height: 12),
          CustomTextField(
            maxLines: 5,
            controller: _descr,
            hintText: 'Description',
            validator: (value) {},
          ),
          const SizedBox(height: 12),
          ImageContainer(images: const <XFile>[]),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _date,
            hintText: 'DateTime',
            focusNode: FocusNode(),
            prefixIcon: const Icon(Icons.calendar_month),
            onTap: () async {
              await DateTimeService.showDateTimePicker(
                context,
                (value) => _date.text = DateFormat("d MMM, y").format(value),
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

// ignore: must_be_immutable
class ImageContainer extends StatefulWidget {
  ImageContainer({
    Key? key,
    required this.images,
  }) : super(key: key);

  List<XFile> images;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final service = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: widget.images.isEmpty
          ? Wrap(
              children: widget.images
                  .map((e) => Expanded(child: Image.file(File(e.path))))
                  .toList(),
            )
          : Center(
              child: IconButton(
                icon: const Icon(
                  Icons.camera_enhance,
                  size: 50,
                ),
                onPressed: () async {
                  final value = await service.pickImages();
                  if (value != null) {
                    widget.images = value;
                    setState(() {});
                  }
                },
              ),
            ),
    );
  }
}
