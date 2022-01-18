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
      } else if (event is LoginSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        // var data = await loginRepo!.login(event.username!, event.password!);
        // if (data["token_type"] == "bearer") {
        //   pref.setString('token', data["access_token"]);
        //   emit(state.copyWith(formStatus: SubmissionSuccess()));
        // } else {
        //   emit(state.copyWith(
        //       formStatus: SubmissionFailed(Exception("failed"))));
        // }
        try {
            var data = await loginRepo!.login(event.username!, event.password!);
            if(data["token_type"] == "bearer"){
              pref.setString('token', data["access_token"]);
              emit(state.copyWith(formStatus: SubmissionSuccess()));
            }
        } on Exception catch (e) {
            emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
}
