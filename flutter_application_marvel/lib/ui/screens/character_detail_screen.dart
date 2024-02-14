import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/characters/characters_bloc_bloc.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class DetailCharacterScreen extends StatefulWidget {
  final int characterId;
  final String nameCharacter;
  const DetailCharacterScreen(
      {super.key, required this.characterId, required this.nameCharacter});

  @override
  State<DetailCharacterScreen> createState() => _DetailCharacterScreenState();
}

class _DetailCharacterScreenState extends State<DetailCharacterScreen> {
  late CharacterRepository characterRepository;
  late CharactersBlocBloc _character;

  @override
  void initState() {
    super.initState();
    characterRepository = CharacterRepositoryImpl();
    _character = CharactersBlocBloc(characterRepository)
      ..add(CharacterFetchDetail(widget.characterId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _character,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detail of ${widget.nameCharacter}'),
          ),
          body: _characterWidget(),
        ));
  }

  Widget _characterWidget() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: BlocBuilder<CharactersBlocBloc, CharactersBlocState>(
            builder: (context, state) {
              if (state is CharacterDetailFetchSuccess) {
                return ListView.builder(
                  itemCount: state.character.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.character[index].thumbnail!.path}.${state.character[index].thumbnail!.extension}";
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: GFCard(
                            title: GFListTile(
                              avatar: GFAvatar(
                                backgroundImage: NetworkImage(image),
                              ),
                              title: Text(state.character[index].name!),
                            ),
                            content: Column(
                              children: <Widget>[
                                Text(
                                  state.character[index].description == ""
                                      ? 'No description data'
                                      : state.character[index].description!,
                                ),
                                Text(
                                    'Resource URI: ${state.character[index].resourceURI!}')
                              ],
                            )),
                      ),
                    );
                  },
                );
              } else if (state is CharacterFetchError) {
                return Text(state.errorMessage);
              } else {
                return const RefreshProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
