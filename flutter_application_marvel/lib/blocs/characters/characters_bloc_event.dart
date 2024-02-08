part of 'characters_bloc_bloc.dart';

@immutable
sealed class CharactersBlocEvent {}

class CharacterFetchList extends CharactersBlocEvent {
  CharacterFetchList();
}
