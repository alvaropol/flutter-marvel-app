import 'package:bloc/bloc.dart';
import 'package:flutter_application_marvel/models/comic_response/comic_response.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:meta/meta.dart';

part 'comics_event.dart';
part 'comics_state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final ComicRepository comicRepository;
  ComicsBloc(this.comicRepository) : super(ComicsInitial()) {
    on<ComicsFetchList>(_onComicsFetchList);
  }

  void _onComicsFetchList(
      ComicsFetchList event, Emitter<ComicsState> emit) async {
    try {
      final comicList = await comicRepository.fetchComics(event.offset);
      emit(ComicsFetchSucess(comicList!));
      return;
    } on Exception catch (e) {
      emit(ComicsFetchError(e.toString()));
    }
  }
}
