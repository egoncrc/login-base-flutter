import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:teslo_shop/features/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return LoginFormNotifier(
      loginUserCallback: loginUserCallback,
      keyValueStorageService: keyValueStorageService);
});

//! 2 - Como implementamos un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  final KeyValueStorageService keyValueStorageService;

  LoginFormNotifier({
    required this.loginUserCallback,
    required this.keyValueStorageService,
  }) : super(LoginFormState()) {
    onFormLoad();
    
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await loginUserCallback(state.email.value, state.password.value);

    if (state.isCredencialsSaved) {
      await keyValueStorageService.setKeyValue('email', state.email.value);
      await keyValueStorageService.setKeyValue('password', state.password.value);
      await keyValueStorageService.setKeyValue('isCredentialsSaved', state.isCredencialsSaved);
    } else {
      await keyValueStorageService.removeKey('email');
      await keyValueStorageService.removeKey('password');
      await keyValueStorageService.removeKey('isCredentialsSaved');
    }

    state = state.copyWith(isPosting: false);
  }

  void toggleCredentialsSaved(bool value) {
    state = state.copyWith(isCredencialsSaved: value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }

  onFormLoad() async {
    final emailPref = await keyValueStorageService.getValue<String>('email');
    final passwordPref = await keyValueStorageService.getValue<String>('password');
    final isCredentialsSavedPref = await keyValueStorageService.getValue<bool>('isCredentialsSaved');
    if (emailPref != null && passwordPref != null) {
      final email = Email.dirty(emailPref);
      final password = Password.dirty(passwordPref);

      state = state.copyWith(          
          email: email,
          password: password,
          isCredencialsSaved: isCredentialsSavedPref,
          isValid: Formz.validate([email, password]));
    }
  }
}

//! 1 - State del provider
class LoginFormState {
  
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isCredencialsSaved;
  final Email email;
  final Password password;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.isCredencialsSaved = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? isCredencialsSaved,
    Email? email,
    Password? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        isCredencialsSaved: isCredencialsSaved ?? this.isCredencialsSaved,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    isCredencialsSaved: $isCredencialsSaved
    email: $email
    password: $password
''';
  }
}
