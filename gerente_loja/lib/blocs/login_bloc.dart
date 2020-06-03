import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatorPassword);

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Stream<LoginState> get outState => _stateController.stream;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  LoginBloc(){
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if(user != null){
      

      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit() {
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).catchError((){
      _stateController.addError(LoginState.FAIL);
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }
}
