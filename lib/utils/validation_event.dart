class ValidationEvent {
  validationFileEvent(value, input) {
    switch (input) {
      case "nameEvent":
        return _validateNameEvent(value.trim());
      case "description":
        return _validateDescription(value.trim());
      default:
      //print("Error al validar la informacion");
    }
  }

  _validateNameEvent(value) {
    if (value!.isEmpty) {
      return 'El campo Nombre del evento es obligatorio';
    }

    if (value.length < 10 || value.length > 100) {
      return 'El campo Nombre del evento requiere el ingreso de entre 5 a 100 caracteres';
    }

    return null;
  }

  _validateDescription(value) {
    if (value!.isEmpty) {
      return 'El campo Descripción es obligatorio';
    }

    if (value.length < 10 || value.length > 600) {
      return 'El campo Descripción requiere el ingreso de entre 10 a 600 caracteres';
    }

    return null;
  }
}
