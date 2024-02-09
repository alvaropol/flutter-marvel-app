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
  late CharacterRepository characterRepository;

  @override
  void initState() {
    super.initState();
    characterRepository = CharacterRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CharactersBlocBloc(characterRepository)..add(CharacterFetchList()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Characters of Marvel'),
          ),
          body: _movieList(),
        ));
  }

  Widget _movieList() {
    return BlocBuilder<CharactersBlocBloc, CharactersBlocState>(
      builder: (context, state) {
        if (state is CharacterFetchSuccess) {
          return ListView.builder(
              itemCount: state.characterList.length,
              itemBuilder: (context, index) {
                String image =
                    "${state.characterList[index].thumbnail!.path}.${state.characterList[index].thumbnail!.extension}";
                return GFCard(
                  boxFit: BoxFit.cover,
                  image: Image.network(image),
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: NetworkImage(image),
                    ),
                    title: Text(state.characterList[index].name!),
                  ),
                  content: Text(state.characterList[index].description!),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {},
                        text: 'Details',
                      ),
                    ],
                  ),
                );
              });
        } else if (state is CharacterFetchError) {
          return Text(state.errorMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
