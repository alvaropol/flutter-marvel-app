import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_marvel/models/character_response/character_response.dart';
import 'package:flutter_application_marvel/models/character_response/detail_character_response.dart';
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
    on<CharacterFetchDetail>(_onCharacterFetchDetail);
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

  Future<FutureOr<void>> _onCharacterFetchDetail(
      CharacterFetchDetail event, Emitter<CharactersBlocState> emit) async {
    try {
      final character =
          await characterRepository.fetchCharacterDetail(event.characterId);
      emit(CharacterDetailFetchSuccess(character!));
    } on Exception catch (e) {
      emit(CharacterFetchError(e.toString()));
    }
  }
}
