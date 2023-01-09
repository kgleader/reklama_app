import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reklama_app/add_product/services/date_time_service.dart';
import 'package:reklama_app/add_product/services/loading_service.dart';
import 'package:reklama_app/add_product/services/storage_service.dart';
import 'package:reklama_app/model/product_model.dart';
import 'package:reklama_app/components/custom_text_field.dart';

import '../../home/page/image_container.dart';
import '../services/store_service.dart';

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
      appBar: AppBar(title: const Text('ЖАРНАМА БЕРУУ')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        children: [
          CustomTextField(
            controller: _title,
            hintText: 'ТЕМА',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            maxLines: 5,
            controller: _descr,
            hintText: 'МААЛЫМАТ',
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
            hintText: 'ДАТАСЫ',
            focusNode: FocusNode(),
            prefixIcon: const Icon(Icons.calendar_month),
            onTap: () async {
              await DateTimeService.showDateTimePicker(
                context,
                (value) => _date.text = DateFormat("d MMM, y").format(value),
              );
            },
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _phn,
            hintText: 'ТЕЛФОН НОМЕРИНИЗ',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _userName,
            hintText: 'АТЫНЫЗ',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _address,
            hintText: 'ДАРЕГИНИЗ',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _price,
            hintText: 'БААСЫ',
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              LoadingService().showLoading(context);
              final urls = await StorageService().upLoadImages(images);
              final product = Product(
                title: _title.text,
                description: _descr.text,
                dateTime: _date.text,
                phoneNumber: _phn.text,
                userName: _userName.text,
                address: _address.text,
                images: urls,
                price: _price.text,
              );
              await StoreService().saveProduct(product);
              // ignore: use_build_context_synchronously
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.publish),
            label: const Text('ТАПШЫР'),
          ),
        ],
      ),
    );
  }
}
