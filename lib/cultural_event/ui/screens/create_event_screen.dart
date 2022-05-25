import 'package:flutter/material.dart';

import 'package:cochabambacultural/utils/app_colors.dart';
import 'package:cochabambacultural/utils/responsive.dart';
import 'package:cochabambacultural/utils/validation_event.dart';

import 'package:cochabambacultural/ui/widgets/text_format_widget.dart';
import 'package:cochabambacultural/ui/widgets/input_text_widget.dart';
import 'package:cochabambacultural/ui/widgets/input_text_area_widget.dart';
import 'package:cochabambacultural/ui/widgets/general_button.dart';

import 'package:cochabambacultural/cultural_event/ui/widgets/radio_button_event.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

  final _event = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final colorApp = AppColors();
    final validate = ValidationEvent();

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
                          inputValidation: (value) =>
                              validate.validationFileEvent(value, 'nameEvent'),
                          controllerText: _event,
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
                            valueText: '* Categoría',
                            align: TextAlign.left,
                            typeText: 'Normal'),
                        SizedBox(
                          height: responsive.hp(1.5),
                        ),
                        RadioButtonEvent(changeCategory: (value) {
                          _categoryEvent = value;
                          print(_categoryEvent);
                        }),
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        GeneralButton(
                            labelButton: 'Crear evento',
                            onPressed: () async {
                              if (_keyForm.currentState!.validate()) {
                                // event - create event
                              }
                            })
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
}
