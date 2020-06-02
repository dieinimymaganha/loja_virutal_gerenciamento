import 'dart:async';

import 'dart:math';

class LoginValidators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Insira um e-mail valido');
    }
  });

  final validatorPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length > 4){
        sink.add(password);
      }else{
        sink.addError('Senha inválida, deve conter pelo menos 4 caracter');
      }
    }
  );
}
