part of 'characters_bloc_bloc.dart';

@immutable
sealed class CharactersBlocEvent {}

class CharacterFetchList extends CharactersBlocEvent {
  final int offset;
  CharacterFetchList(this.offset);
}

class CharacterFetchDetail extends CharactersBlocEvent {
  final int characterId;
  CharacterFetchDetail(this.characterId);
}
