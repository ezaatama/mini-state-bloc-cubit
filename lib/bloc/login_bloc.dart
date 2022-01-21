import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_cubit/bloc/form_submission_status.dart';
import 'package:state_cubit/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository? loginRepo;

  LoginBloc({this.loginRepo}) : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      var pref = await SharedPreferences.getInstance();
      //username updated
      if (event is LoginUsernameChanged) {
        emit(state.copyWith(username: event.username));

        //password updated
      } else if (event is LoginPasswordChanged) {
        emit(state.copyWith(password: event.password));

        //form submitted
      } else if (event is LoggedIn) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        try {
            var data = await loginRepo!.login(event.username!, event.password!);
            if(data["roles"] == "Superadmin"){
              pref.setString('token', data["access_token"]);
              pref.setString('roles', data["roles"]);
              emit(state.copyWith(formStatus: AdminSubmissionSuccess()));
            }else if(data["roles"] == "Provinsi"){
              pref.setString('token', data["access_token"]);
              pref.setString('roles', data["roles"]);
              emit(state.copyWith(formStatus: UserSubmissionSuccess()));
            }
        } on Exception catch (e) {
            emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      } else if(event is LoggedOut){
          emit(state.copyWith(formStatus: InitialFormStatus()));
          pref.clear();
          await loginRepo!.deleteToken();
          emit(state.copyWith(formStatus: InitialFormStatus()));
      }
    });
  }
}
