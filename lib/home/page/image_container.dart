import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../add_product/services/image_picker_service.dart';
import 'image_card.dart';

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
                  fit: StackFit.expand,
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
