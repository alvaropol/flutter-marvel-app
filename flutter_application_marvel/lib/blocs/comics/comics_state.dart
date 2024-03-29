part of 'comics_bloc.dart';

@immutable
sealed class ComicsState {}

final class ComicsInitial extends ComicsState {}

final class ComicsFetchSucess extends ComicsState {
  final List<Comics> comicsList;
  ComicsFetchSucess(this.comicsList);
}

final class ComicDetailFetchSucess extends ComicsState {
  final List<Comic> comic;
  ComicDetailFetchSucess(this.comic);
}

final class ComicsFetchError extends ComicsState {
  final String errorMessage;
  ComicsFetchError(this.errorMessage);
}
