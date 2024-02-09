import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_marvel/models/character_response/character_response.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:meta/meta.dart';

part 'characters_bloc_event.dart';
part 'characters_bloc_state.dart';

class CharactersBlocBloc
    extends Bloc<CharactersBlocEvent, CharactersBlocState> {
  final CharacterRepository characterRepository;

  CharactersBlocBloc(this.characterRepository)
      : super(CharactersBlocInitial()) {
    on<CharacterFetchList>(_onCharacterFetchList);
  }

  Future<FutureOr<void>> _onCharacterFetchList(
      CharacterFetchList event, Emitter<CharactersBlocState> emit) async {
    try {
      final characterList =
          await characterRepository.fetchCharacterList(event.offset);
      emit(CharacterFetchSuccess(characterList!));
    } on Exception catch (e) {
      emit(CharacterFetchError(e.toString()));
    }
  }
}
