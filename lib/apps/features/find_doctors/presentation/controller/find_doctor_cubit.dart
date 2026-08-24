import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'find_doctor_state.dart';

/// Tracks favorited doctors on the Find Doctors screen.
@injectable
class FindDoctorCubit extends Cubit<FindDoctorState> {
  FindDoctorCubit() : super(const FindDoctorState());

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(FindDoctorState(favoritedIds: {...ids}));
  }

  void toggleFavorite(String id) {
    final ids = {...state.favoritedIds};
    if (!ids.remove(id)) ids.add(id);
    emit(FindDoctorState(favoritedIds: ids));
  }
}
