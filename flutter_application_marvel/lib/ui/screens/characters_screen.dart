import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/characters/characters_bloc_bloc.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  int offset = 0;
  late CharacterRepository characterRepository;
  late CharactersBlocBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    characterRepository = CharacterRepositoryImpl();
    _characterBloc = CharactersBlocBloc(characterRepository)
      ..add(CharacterFetchList(offset));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _characterBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Characters of Marvel'),
          ),
          body: _characterList(),
        ));
  }

  Widget _characterList() {
    return Column(
      children: [
        if (offset != 0)
          ElevatedButton(
            onPressed: () {
              setState(() {
                offset -= 20;
              });
              _characterBloc = CharactersBlocBloc(characterRepository)
                ..add(CharacterFetchList(offset));
            },
            child: const Text('Return to the other characters'),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              offset += 20;
            });
            _characterBloc = CharactersBlocBloc(characterRepository)
              ..add(CharacterFetchList(offset));
          },
          child: const Text('Show next characters'),
        ),
        Expanded(
          child: BlocBuilder<CharactersBlocBloc, CharactersBlocState>(
            builder: (context, state) {
              if (state is CharacterFetchSuccess) {
                return ListView.builder(
                  itemCount: state.characterList.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.characterList[index].thumbnail!.path}.${state.characterList[index].thumbnail!.extension}";
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white
                              .withOpacity(0.5), // Fondo transparente blanco
                        ),
                        child: GFCard(
                          title: GFListTile(
                            avatar: GFAvatar(
                              backgroundImage: NetworkImage(image),
                            ),
                            title: Text(state.characterList[index].name!),
                          ),
                          content: Text(
                            state.characterList[index].description == ""
                                ? 'No description data'
                                : state.characterList[index].description!,
                          ),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              GFButton(
                                onPressed: () {},
                                text: 'Details',
                              ),
                            ],
                          ),
                        ),
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
