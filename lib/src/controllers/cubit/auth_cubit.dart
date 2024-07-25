import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthCubitInitial()) {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(state.copyWith(
        signed: true,
        uid: FirebaseAuth.instance.currentUser!.uid,
      ));
    }

    FirebaseAuth.instance.userChanges().listen((e) {
      if (e == null) {
        emit(state.copyWith(
          signed: false,
          uid: "",
        ));
      } else {
        emit(state.copyWith(
          signed: true,
          uid: e.uid,
        ));
      }
    });
  }
}
