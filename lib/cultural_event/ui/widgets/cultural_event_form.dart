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

import 'package:cochabambacultural/cultural_event/ui/widgets/radio_button_event.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/add_image_event.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/add_tag.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CulturalEventForm extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final TextEditingController eventName;
  final TextEditingController description;
  final TextEditingController costEvent;
  final TextEditingController transport;
  final TextEditingController category;

  final List<String> principalImage;
  final List<String> secondaryImages;

  final List<String> tags;

  final String labelButtonForm;
  final Function formEvent;

  const CulturalEventForm(
      {Key? key,
      required this.keyForm,
      required this.eventName,
      required this.description,
      required this.costEvent,
      required this.transport,
      required this.category,
      required this.principalImage,
      required this.secondaryImages,
      required this.tags,
      required this.labelButtonForm,
      required this.formEvent})
      : super(key: key);

  @override
  State<CulturalEventForm> createState() => _CulturalEventFormState();
}

class _CulturalEventFormState extends State<CulturalEventForm> {
  final double _pricipalImgHeight = 5;
  final double _secondaryImgHeight = 5;

  final int maxImagePrincipal = 1;
  final int maxImagesSecondary = 4;

  bool _errorTag = false;

  final colorApp = AppColors();

  final validate = ValidationEvent();

  final SnackMessages snackMessages = SnackMessages();

  final LoadImage loadImage = LoadImage();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

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
                key: widget.keyForm,
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
                          controllerText: widget.eventName,
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
                            controllerText: widget.description,
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
                          setState(() {
                            widget.category.text = value;
                          });
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
                            images: widget.principalImage,
                            addImage: () => loadImage.loadImage(
                                widget.principalImage.length,
                                maxImagePrincipal,
                                context)),
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
                            images: widget.secondaryImages,
                            addImage: () => loadImage.loadImage(
                                widget.secondaryImages.length,
                                maxImagesSecondary,
                                context)),
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
                        AddTag(tags: widget.tags),
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
                          controllerText: widget.costEvent,
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
                            controllerText: widget.transport,
                            maxCharacters: 150),
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        GeneralButton(
                            labelButton: widget.labelButtonForm,
                            onPressed: () {
                              _showErrorLabels(widget.tags.isEmpty);
                              if (widget.keyForm.currentState!.validate()) {
                                if (widget.tags.isEmpty) {
                                  return;
                                }
                                widget.formEvent();
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

  _showErrorLabels(bool showMessageTag) {
    setState(() {
      _errorTag = showMessageTag;
    });
  }
}
