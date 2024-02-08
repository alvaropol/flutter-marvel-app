part of 'characters_bloc_bloc.dart';

@immutable
sealed class CharactersBlocState {}

final class CharactersBlocInitial extends CharactersBlocState {}

final class CharacterFetchSuccess extends CharactersBlocState {
  final List<Character> characterList;
  CharacterFetchSuccess(this.characterList);
}

final class CharacterFetchError extends CharactersBlocState {
  final String errorMessage;
  CharacterFetchError(this.errorMessage);
}
