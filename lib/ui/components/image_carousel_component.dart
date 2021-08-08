import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_task/ui/utils/colors.dart';

class ImageCarouselComponent extends StatefulWidget {
  const ImageCarouselComponent(
      {Key? key,
      this.images = const [],
      this.onFocusedImageChanged,
      this.onImageClick,
      this.onImageAdded,
      this.maxImageCount = 5})
      : super(key: key);

  final List<File> images;
  final Function(int index)? onFocusedImageChanged;
  final Function(int index)? onImageClick;
  final Function(File addedImage)? onImageAdded;
  final maxImageCount;

  @override
  _ImageCarouselComponentState createState() => _ImageCarouselComponentState();
}

class _ImageCarouselComponentState extends State<ImageCarouselComponent> {
  var _currentImageIndex = 0;
  List<Widget> _carouselItems = [];

  @override
  Widget build(BuildContext context) {
    _carouselItems = _buildImagesToCarousel();
    _carouselItems.add(_buildImagePickerToCarousel());

    return Column(
      children: [
        CarouselSlider(
          items: _carouselItems,
          options: CarouselOptions(
              reverse: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });

                if (widget.onFocusedImageChanged != null) {
                  widget.onFocusedImageChanged!(index);
                }
              },
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false),
        ),
        _buildISelectedItemIndicator(),
      ],
    );
  }

  Widget _buildISelectedItemIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _carouselItems
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor:
                        _currentImageIndex == _carouselItems.indexOf(e)
                            ? AppColors.elPrimary
                            : AppColors.elSecondary,
                  ),
                ))
            .toList(),
      ),
    );
  }

  List<Widget> _buildImagesToCarousel() {
    return widget.images
        .map((e) => InkWell(
              onTap: () {
                if (widget.onImageClick != null) {
                  widget.onImageClick!(widget.images.indexOf(e));
                }
              },
              child: Container(
                width: 1.sw,
                child: Image.file(
                  e,
                  fit: BoxFit.cover,
                ),
              ),
            ))
        .toList();
  }

  Widget _buildImagePickerToCarousel() {
    return InkWell(
      onTap: () async {
        var image = await _pickImage();
        if (image != null && widget.onImageAdded != null) {
          widget.onImageAdded!(image);
        }
      },
      child: Container(
        color: Colors.black,
        width: 1.sw,
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 48.w,
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }
}
