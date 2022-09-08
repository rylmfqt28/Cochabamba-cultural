class ValidationEvent {
  validationFileEvent(value, input) {
    switch (input) {
      case "nameEvent":
        return _validateNameEvent(value.trim());
      case "description":
        return _validateDescription(value.trim());
      case "transport":
        return _validateTransport(value.trim());
      case "costEvent":
        return _validateCostEvent(value.trim());
      case "tagName":
        return _validateTagName(value.trim());
      default:
      //print("Error al validar la informacion");
    }
  }

  _validateNameEvent(value) {
    if (value!.isEmpty) {
      return 'El campo Nombre del evento es obligatorio.';
    }

    if (value.length < 5 || value.length > 100) {
      return 'El campo Nombre del evento requiere el ingreso de entre 5 a 100 caracteres.';
    }

    return null;
  }

  _validateDescription(value) {
    if (value!.isEmpty) {
      return 'El campo Descripción es obligatorio.';
    }

    if (value.length < 10 || value.length > 600) {
      return 'El campo Descripción requiere el ingreso de entre 10 a 600 caracteres.';
    }

    return null;
  }

  _validateCostEvent(value) {
    final n = num.tryParse(value);
    if (n == null && !value.isEmpty) {
      return 'El campo Precio solo acepta caracteres numéricos';
    }

    return null;
  }

  _validateTransport(value) {
    if (value.length > 150) {
      return 'El campo Transporte acepta como maximo 150 caracteres.';
    }

    return null;
  }

  _validateTagName(value) {
    if (value!.isEmpty) {
      return 'El campo Etiqueta es obligatorio.';
    }
    if (value.length < 4 || value.length > 20) {
      return 'El campo Etiqueta requiere el ingreso de entre 4 a 20 caracteres';
    }
  }
}
