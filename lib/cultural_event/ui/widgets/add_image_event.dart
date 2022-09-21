import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/add_button.dart';

class AddImageEvent extends StatefulWidget {
  final List<String> images;
  final Function addImage;

  const AddImageEvent({
    Key? key,
    required this.images,
    required this.addImage,
  }) : super(key: key);

  @override
  State<AddImageEvent> createState() => _AddImageEventState();
}

class _AddImageEventState extends State<AddImageEvent> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();

    const double iconSize = 20.0;

    return Column(
      children: [
        SizedBox(
          height: responsive.hp(8),
          child: Row(
            children: [
              AddButton(
                  iconAdd: Icons.add_photo_alternate_rounded, event: () {}),
              SizedBox(
                width: responsive.hp(2.2),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: responsive.wp(2)),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: responsive.hp(8),
                          width: responsive.wp(13),
                          child: widget.images[index].contains("https://")
                              ? Image.network(
                                  widget.images[index],
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(widget.images[index]),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.images.removeAt(index);
                              });
                            },
                            alignment: Alignment.topLeft,
                            icon: Icon(Icons.close_rounded,
                                size: iconSize, color: colorApp.primaryColor),
                            iconSize: iconSize),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
