part of 'comics_bloc.dart';

@immutable
sealed class ComicsEvent {}

class ComicsFetchList extends ComicsEvent {
  final int offset;
  ComicsFetchList(this.offset);
}
