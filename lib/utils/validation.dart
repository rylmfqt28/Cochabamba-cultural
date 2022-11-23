class Validation {
  validationField(value, input, [valueAux = '']) {
    switch (input) {
      case "email":
        return _isEmail(value.trim());
      case "userName":
        return _validateName(value.trim());
      case "passwordR":
        // password -> screen user register
        return _passwordRegister(value.trim());
      case "confirmPassword":
        // confirm password -> screen user register
        return _confirmPassword(value.trim(), valueAux.trim());
      default:
      //print("Error al validar la informacion");
    }
  }

  _isEmail(value) {
    if (value!.isEmpty) {
      return 'El campo Correo es obligatorio';
    }

    String p =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    if (!RegExp(p).hasMatch(value)) {
      return 'Formato de correo no valido';
    }
    return null;
  }

  _validateName(value) {
    if (value!.isEmpty) {
      return 'El campo Nombre es obligatorio';
    }
    if (value.length < 3 || value.length > 60) {
      return 'El campo Nombre requiere el ingreso de entre 3 a 60 caracteres';
    }
    return null;
  }

  _passwordRegister(value) {
    if (value!.isEmpty) {
      return 'El campo Contraseña es obligatorio';
    }
    if (value.length < 8 || value.length > 15) {
      return 'El campo Contraseña requiere el ingreso de entre 8 a 15 caracteres';
    }
    return null;
  }

  _confirmPassword(value, valueConfirm) {
    if (value!.isEmpty) {
      return 'El campo Confirmar contraseña es obligatorio';
    }
    if (value != valueConfirm) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
