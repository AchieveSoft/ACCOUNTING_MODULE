import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class CommonScaffoldBloc
    extends Bloc<CommonScaffoldEvent, CommonScaffoldState> {
  CommonScaffoldBloc()
    : super(CommonScaffoldState(currentSelectKey: "", currentSelectTitle: "")) {
      on<CommonScaffoldSelectMenuEvent>(_onSelectMenu);
    }

  Future<void> _onSelectMenu(
    CommonScaffoldSelectMenuEvent event,
    Emitter<CommonScaffoldState> emit,
  ) async {
    emit(
      CommonScaffoldState(
        currentSelectKey: event.key,
        currentSelectTitle: event.title,
      ),
    );
  }
}
