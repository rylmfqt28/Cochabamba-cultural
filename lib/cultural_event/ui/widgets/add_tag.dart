import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/snack_messages.dart';
import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/validation_event.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/add_button.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/tag_chip.dart';

import 'package:cochabambacultural/ui/widgets/dialog_widget.dart';

class AddTag extends StatefulWidget {
  final List<String> tags;

  const AddTag({Key? key, required this.tags}) : super(key: key);

  @override
  State<AddTag> createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  final SnackMessages snackMessages = SnackMessages();

  final colorApp = AppColors();
  final validate = ValidationEvent();

  final int _maxTags = 5;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SizedBox(
      height: responsive.hp(5),
      child: Row(
        children: [
          AddButton(
              iconAdd: Icons.add,
              event: () {
                if (widget.tags.length < _maxTags) {
                  _showDialog(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      snackMessages.getSnack(
                          "No es posible agregar mas etiquetas.",
                          colorApp.infoColor,
                          context,
                          140));
                }
              }),
          SizedBox(
            width: responsive.wp(2),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: responsive.wp(2)),
                itemCount: widget.tags.length,
                itemBuilder: (context, index) {
                  return TagChip(
                      labelTag: widget.tags[index],
                      deleteEvent: () => {
                            setState(() {
                              widget.tags.remove(widget.tags[index]);
                            })
                          });
                }),
          )
        ],
      ),
    );
  }

  _showDialog(BuildContext context) {
    final GlobalKey<FormState> _keyFormDialog = GlobalKey();

    final _newTag = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: colorApp.primaryBackground,
            insetPadding: const EdgeInsets.all(15),
            child: Form(
              key: _keyFormDialog,
              child: DialogWidget(
                titleText: 'Crear Etiqueta',
                subTitle: 'Ingrese la etiqueta que quiera agregar al evento.',
                labelInputDialog: 'Etiqueta',
                hintInputDialog: 'Ingrese la etiqueta',
                keyboardType: TextInputType.text,
                isPassword: false,
                inputValidation: (value) => validate.validateTagNameField(
                    value!, widget.tags.length, widget.tags),
                controller: _newTag,
                labelButtonModal: 'Crear',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    setState(() {
                      widget.tags.add(_newTag.text);
                    });
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  }
                },
              ),
            )));
  }
}
