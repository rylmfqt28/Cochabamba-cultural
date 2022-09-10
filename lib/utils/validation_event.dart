class ValidationEvent {
  validationFileEvent(value, input) {
    switch (input) {
      case "eventName":
        return _validateNameEvent(value.trim());
      case "description":
        return _validateDescription(value.trim());
      case "transport":
        return _validateTransport(value.trim());
      case "costEvent":
        return _validateCostEvent(value.trim());
      default:
        return 'La validacion fallo.';
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

  validateTagNameField(String valueTag, int length, List<String> tags) {
    if (length >= 5) {
      return 'Ya se agregaron 5 etiquetas';
    }

    if (valueTag.isEmpty) {
      return 'El campo Etiqueta es obligatorio.';
    }

    if (valueTag.length < 3 || valueTag.length > 15) {
      return 'El campo Etiqueta requiere el ingreso de entre 3 a 15 caracteres';
    }

    if (tags.isNotEmpty) {
      List<String> auxTags = tags.map((tag) => tag.toLowerCase()).toList();
      if (auxTags.contains(valueTag.toLowerCase())) {
        return 'La etiqueta ya se encuentra agregada.';
      }
    }

    return null;
  }
}
