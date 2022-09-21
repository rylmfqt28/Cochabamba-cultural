import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/validation_event.dart';
import 'package:cochabambacultural/utils/snack_messages.dart';
import 'package:cochabambacultural/utils/load_image.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/input_text_area_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';
import 'package:cochabambacultural/ui/widgets/dialog_widget.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/radio_button_event.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/add_button.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/tag_chip.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/add_image_event.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final colorApp = AppColors();
  final validate = ValidationEvent();
  final SnackMessages snackMessages = SnackMessages();
  final LoadImage loadImage = LoadImage();

  final _eventName = TextEditingController();
  final _description = TextEditingController();
  final _costEvent = TextEditingController();
  final _transport = TextEditingController();

  final double _pricipalImgHeight = 5;
  final double _secondaryImgHeight = 5;

  List<String> _tags = [];

  List<String> principalImage = [];
  List<String> secondaryImages = [];

  bool _errorTag = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    String _categoryEvent = 'Gastronómico';

    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      return Scaffold(
        backgroundColor: colorApp.primaryBackground,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: responsive.isTablet ? 430 : 360),
              child: Form(
                key: _keyForm,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: colorApp.primaryColor,
                                size: responsive.dp(3.5),
                              ),
                            ),
                            SizedBox(
                              width: responsive.wp(3.5),
                            ),
                            const TextFormatWidget(
                                valueText: 'Crear Evento',
                                align: TextAlign.left,
                                typeText: 'Title')
                          ],
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        const TextFormatWidget(
                            valueText:
                                'Los campos con un (*) son de caracter obligatorio.',
                            align: TextAlign.left,
                            typeText: 'Normal'),
                        SizedBox(
                          height: responsive.hp(2.5),
                        ),
                        InputTextWidget(
                          labelInput: '* Nombre del evento',
                          hintInput: 'Ingrese el nombre del evento',
                          inputPassword: false,
                          controllerText: _eventName,
                          inputValidation: (value) =>
                              validate.validationFileEvent(value, 'eventName'),
                        ),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        InputTextAreaWidget(
                            labelInput: '* Descripción',
                            hintInput: 'Ingrese la descripción del evento',
                            inputValidation: (value) => validate
                                .validationFileEvent(value, "description"),
                            controllerText: _description,
                            maxCharacters: 600),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Fecha de inicio',
                            align: TextAlign.left,
                            typeText: 'Normal'),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Fecha fin',
                            align: TextAlign.left,
                            typeText: 'Normal'),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Categoría',
                            align: TextAlign.left,
                            typeText: 'LabelTitleForm'),
                        SizedBox(
                          height: responsive.hp(1.5),
                        ),
                        RadioButtonEvent(changeCategory: (value) {
                          _categoryEvent = value;
                        }),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Ubicación',
                            align: TextAlign.left,
                            typeText: 'Normal'),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Imagen principal',
                            align: TextAlign.left,
                            typeText: 'LabelTitleForm'),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        AddImageEvent(
                            images: principalImage,
                            addImage: () => loadImage.loadImage(
                                principalImage.length, 1, context)),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: 'Imagenes secundarias',
                            align: TextAlign.left,
                            typeText: 'LabelTitleForm'),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        AddImageEvent(
                            images: secondaryImages,
                            addImage: () => loadImage.loadImage(
                                secondaryImages.length, 4, context)),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        const TextFormatWidget(
                            valueText: '* Etiquetas',
                            align: TextAlign.left,
                            typeText: 'LabelTitleForm'),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        SizedBox(
                          height: responsive.hp(5),
                          child: Row(
                            children: [
                              AddButton(
                                  iconAdd: Icons.add,
                                  event: () {
                                    if (_tags.length < 5) {
                                      _showDialog(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackMessages.getSnack(
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
                                    padding:
                                        EdgeInsets.only(left: responsive.wp(2)),
                                    itemCount: _tags.length,
                                    itemBuilder: (context, index) {
                                      return TagChip(
                                          labelTag: _tags[index],
                                          deleteEvent: () => {
                                                setState(() {
                                                  _tags.remove(_tags[index]);
                                                })
                                              });
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(1.9),
                        ),
                        Visibility(
                          child: const TextFormatWidget(
                              valueText:
                                  'Es necesario añadir al menos 1 etiqueta.',
                              align: TextAlign.left,
                              typeText: 'LabelErrorForm'),
                          visible: _errorTag,
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        InputTextWidget(
                          labelInput: 'Precio',
                          hintInput: 'Ingrese el precio de entrada al evento',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputPassword: false,
                          inputValidation: (value) =>
                              validate.validationFileEvent(value, 'costEvent'),
                          controllerText: _costEvent,
                        ),
                        SizedBox(
                          height: responsive.hp(2.2),
                        ),
                        InputTextAreaWidget(
                            labelInput: 'Transporte',
                            hintInput:
                                'Ingrese los diferentes medios de transporte para llegar al lugar del evento',
                            inputValidation: (value) => validate
                                .validationFileEvent(value, "transport"),
                            controllerText: _transport,
                            maxCharacters: 150),
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        GeneralButton(
                            labelButton: 'Crear evento',
                            onPressed: () {
                              _showErrorLabels(_tags.isEmpty);
                              if (_keyForm.currentState!.validate()) {
                                if (_tags.isEmpty) {
                                  return;
                                }
                              }
                            }),
                        SizedBox(
                          height: responsive.hp(5),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
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
                inputValidation: (value) =>
                    validate.validateTagNameField(value!, _tags.length, _tags),
                controller: _newTag,
                labelButtonModal: 'Crear',
                onPressed: () async {
                  if (_keyFormDialog.currentState!.validate()) {
                    setState(() {
                      _tags.add(_newTag.text);
                    });
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  }
                },
              ),
            )));
  }

  _showErrorLabels(bool msgTag) {
    setState(() {
      _errorTag = msgTag;
    });
  }
}
