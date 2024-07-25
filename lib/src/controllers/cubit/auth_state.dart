// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String uid;
  final bool signed;

  User? get getUser => FirebaseAuth.instance.currentUser;

  const AuthState({required this.uid, required this.signed});

  @override
  List<Object> get props => [uid, signed];

  AuthState copyWith({
    String? uid,
    bool? signed,
  }) {
    return AuthState(
      uid: uid ?? this.uid,
      signed: signed ?? this.signed,
    );
  }
}

class AuthCubitInitial extends AuthState {
  const AuthCubitInitial() : super(signed: false, uid: "");
}
