import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'favourite_doctors_state.dart';

/// Tracks favorited doctors on the Favourite Doctors screen.
@injectable
class FavouriteDoctorsCubit extends Cubit<FavouriteDoctorsState> {
  FavouriteDoctorsCubit() : super(const FavouriteDoctorsState());

  void setInitialFavorites(Iterable<String> ids) {
    if (state.favoritedIds.isNotEmpty) return;
    emit(FavouriteDoctorsState(favoritedIds: {...ids}));
  }

  void toggleFavorite(String id) {
    final ids = {...state.favoritedIds};
    if (!ids.remove(id)) ids.add(id);
    emit(FavouriteDoctorsState(favoritedIds: ids));
  }
}
