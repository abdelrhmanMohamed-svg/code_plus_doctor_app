import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'doctor_details_state.dart';

/// Tracks favorited doctors on the Doctor Details screen.
@injectable
class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(const DoctorDetailsState());

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(DoctorDetailsState(favoritedIds: {...ids}));
  }

  void toggleFavorite(String id) {
    final ids = {...state.favoritedIds};
    if (!ids.remove(id)) ids.add(id);
    emit(DoctorDetailsState(favoritedIds: ids));
  }
}
