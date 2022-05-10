class Validators {
  Validators._();

  factory Validators() {
    return _instance;
  }

  static final Validators _instance = Validators._();

  String? validateEmail(String input) {
    {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(input.trim())) {
        return 'Ingrese un e-mail valido';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(input) {
    if (input.trim().length < 6) {
      return 'La contraseña debe tener mínimo 6 caracteres';
    }

    if (input.trim().length > 20) {
      return 'La contraseña debe tener máximo 20 caracteres';
    }

    return null;
  }

  String? validateText(input) {
    if (input.trim() == "" || input.trim().length < 1) {
      return 'Este campo es obligatorio';
    } else {
      return null;
    }
  }
}

Validators validators = Validators();
