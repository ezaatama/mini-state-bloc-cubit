import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_cubit/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repo;
  AuthBloc(AuthInitial initialState, this.repo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      var pref = await SharedPreferences.getInstance();
      if (event is StartEvent) {
        emit(AuthInitial());
      }else if(event is LoginButtonPressed){
        emit(AuthLoading());
        var data = await repo.login(event.username!, event.password!);
        if(data["token_type"] == "bearer"){
          pref.setString('token', data["access_token"]);
          emit(AuthSuccess());
        }else{
          emit(AuthError(message: "Authentication Error"));
        }
      }else{
        emit(AuthInitial());
      }
    });
  }
}
