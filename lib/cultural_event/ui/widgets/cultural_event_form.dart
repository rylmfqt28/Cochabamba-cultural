import 'package:flutter/material.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/add_button.dart';
import 'package:cochabambacultural/cultural_event/ui/widgets/map_widget.dart';

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
import 'package:cochabambacultural/cultural_event/ui/widgets/input_field_date.dart';

import 'package:cochabambacultural/cultural_event/utils/modal_button_sheet.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CulturalEventForm extends StatefulWidget {
  final TextEditingController eventName;
  final TextEditingController description;
  final TextEditingController costEvent;
  final TextEditingController transport;

  final int actualEventType;
  final TextEditingController category;

  final LatLng initialLocation;
  final List<Marker> markers;

  final TextEditingController location;

  final TextEditingController controllerInitialDateTime;
  final DateTime initialDateTime;

  final TextEditingController controllerEndDateTime;
  final DateTime endDateTime;

  final List<String> principalImage;
  final List<String> secondaryImages;

  final List<String> tags;

  final String labelButtonForm;
  final Function formEvent;

  const CulturalEventForm(
      {Key? key,
      required this.eventName,
      required this.description,
      required this.costEvent,
      required this.transport,
      required this.actualEventType,
      required this.category,
      required this.initialLocation,
      required this.location,
      required this.markers,
      required this.controllerInitialDateTime,
      required this.initialDateTime,
      required this.controllerEndDateTime,
      required this.endDateTime,
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
  final int maxImagePrincipal = 1;
  final int maxImagesSecondary = 4;

  bool _errorTag = false;
  bool _errorPrincipalImage = false;

  final colorApp = AppColors();

  final validate = ValidationEvent();

  final SnackMessages snackMessages = SnackMessages();

  final LoadImage loadImage = LoadImage();

  final _keyForm = GlobalKey<FormState>();

  final ModalButtonSheet _modalButtonSheet = ModalButtonSheet();

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
                key: _keyForm,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: responsive.hp(12),
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
                              height: responsive.hp(2.2),
                            ),
                            InputTextWidget(
                                labelInput: '* Nombre del evento',
                                hintInput: 'Ingrese el nombre del evento',
                                inputValidation: (value) => validate
                                    .validationFileEvent(value, 'eventName'),
                                controllerText: widget.eventName,
                                inputPassword: false),
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
                            InputFieldDate(
                                labelInput: 'Fecha y hora de inicio',
                                hintInput:
                                    'Ingrese fecha y hora de inicio del evento',
                                initialDateTime: widget.initialDateTime,
                                controllerDateTime:
                                    widget.controllerInitialDateTime),
                            SizedBox(
                              height: responsive.hp(2.2),
                            ),
                            InputFieldDate(
                                labelInput: 'Fecha y hora de finalización',
                                hintInput:
                                    'Ingrese fecha y hora de finalización del evento',
                                initialDateTime: widget.endDateTime,
                                controllerDateTime:
                                    widget.controllerEndDateTime),
                            SizedBox(
                              height: responsive.hp(2.8),
                            ),
                            const TextFormatWidget(
                                valueText: '* Categoría',
                                align: TextAlign.left,
                                typeText: 'LabelTitleForm'),
                            SizedBox(
                              height: responsive.hp(1.5),
                            ),
                            RadioButtonEvent(
                              changeCategory: (value) {
                                setState(() {
                                  widget.category.text = value;
                                });
                              },
                              actualValueRadio: widget.actualEventType,
                            ),
                            SizedBox(
                              height: responsive.hp(2.2),
                            ),
                            InputTextAreaWidget(
                                labelInput: '* Ubicación',
                                hintInput: 'Ingrese la ubicación del evento',
                                inputValidation: (value) =>
                                    validate.validateLocation(value!),
                                controllerText: widget.location,
                                maxCharacters: 200),
                            SizedBox(
                              height: responsive.hp(1.5),
                            ),
                            AddButton(
                                iconAdd: Icons.add_location_alt,
                                event: () {
                                  _modalButtonSheet.showModal(
                                      context,
                                      MapWidget(
                                        initialLocation: widget.initialLocation,
                                        markers: widget.markers,
                                        location: widget.location,
                                      ));
                                }),
                            SizedBox(
                              height: responsive.hp(3),
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
                              height: responsive.hp(1.9),
                            ),
                            Visibility(
                              child: const TextFormatWidget(
                                  valueText:
                                      'Es necesario añadir una imagen principal.',
                                  align: TextAlign.left,
                                  typeText: 'LabelErrorForm'),
                              visible: _errorPrincipalImage,
                            ),
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
                              hintInput:
                                  'Ingrese el precio de entrada al evento',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputPassword: false,
                              inputValidation: (value) => validate
                                  .validationFileEvent(value, 'costEvent'),
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
                                  _showErrorLabels();
                                  if (_keyForm.currentState!.validate()) {
                                    if (_fieldSpecialValidate()) {
                                      return;
                                    }
                                    widget.formEvent();
                                  }
                                }),
                            SizedBox(
                              height: responsive.hp(5),
                            ),
                          ]),
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

  _showErrorLabels() {
    setState(() {
      _errorTag = widget.tags.isEmpty;
      _errorPrincipalImage = widget.principalImage.isEmpty;
    });
  }

  bool _fieldSpecialValidate() {
    if (_errorTag) {
      return true;
    }
    if (_errorPrincipalImage) {
      return true;
    }

    return false;
  }
}
