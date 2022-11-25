import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../components/custom_text_field.dart';
import '../services/date_time_service.dart';
import '../services/image_picker_service.dart';

// ignore: must_be_immutable
class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final _title = TextEditingController();
  final _descr = TextEditingController();
  final _date = TextEditingController();
  final _phn = TextEditingController();
  final _userName = TextEditingController();
  final _address = TextEditingController();
  final _price = TextEditingController();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppProductPage')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        children: [
          CustomTextField(
            controller: _title,
            hintText: 'Title',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            maxLines: 5,
            controller: _descr,
            hintText: 'Description',
          ),
          const SizedBox(height: 12),
          ImageContainer(
            images: images,
            onPicked: (value) => images = value,
            delete: (xfile) => images.remove(xfile),
          ),
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
          ),
          CustomTextField(
            controller: _phn,
            hintText: 'Phone number',
          ),
          CustomTextField(
            controller: _userName,
            hintText: 'User name',
          ),
          CustomTextField(
            controller: _address,
            hintText: 'Address',
          ),
          CustomTextField(
            controller: _price,
            hintText: 'Price',
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
    required this.onPicked,
    required this.delete,
  }) : super(key: key);

  List<XFile> images;
  final void Function(List<XFile> images) onPicked;
  final void Function(XFile) delete;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final service = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.images.isNotEmpty
            ? SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 120,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ImageCard(
                          widget.images[index],
                          delete: (xfile) {
                            widget.images.remove(xfile);
                            widget.delete(xfile);
                            setState(() {});
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_enhance,
                          size: 30,
                        ),
                        onPressed: () async {
                          final value = await service.pickImages();
                          if (value != null) {
                            widget.onPicked(value);
                            widget.images = value;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_enhance,
                      size: 50,
                    ),
                    onPressed: () async {
                      final value = await service.pickImages();
                      if (value != null) {
                        widget.onPicked(value);
                        widget.images = value;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard(
    this.file, {
    Key? key,
    required this.delete,
  }) : super(key: key);
  final XFile file;
  final void Function(XFile) delete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          Image.file(
            File(file.path),
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () => delete(file),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
