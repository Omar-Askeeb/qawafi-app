import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/support/domain/usecases/supportUseCase.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final SentContactUseCase _sentContactUseCase;
  ContactBloc({required SentContactUseCase sentContactUseCase})
      : _sentContactUseCase = sentContactUseCase,
        super(ContactInitial()) {
    on<ContactSendEvent>(_onContactSendEvent);
  }

  _onContactSendEvent(ContactSendEvent event, emit) async {
    emit(ContactLoading());

    var res = await _sentContactUseCase(
        title: event.title,
        description: event.content,
        email: event.email,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber);

    res.fold((onLeft) => emit(ContactFailure(message: onLeft.message)),
        (onRight) => emit(ContactLoaded()));
  }
}
