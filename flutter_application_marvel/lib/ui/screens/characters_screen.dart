import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/characters/characters_bloc_bloc.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository_impl.dart';
import 'package:flutter_application_marvel/ui/screens/character_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

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
      ),
    );
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
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              child: const Text('Return to the other characters',
                  style: TextStyle(color: Colors.white))),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              setState(() {
                offset += 20;
              });
              _characterBloc = CharactersBlocBloc(characterRepository)
                ..add(CharacterFetchList(offset));
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black)),
            child: const Text('Show next characters',
                style: TextStyle(color: Colors.white))),
        Expanded(
          child: BlocBuilder<CharactersBlocBloc, CharactersBlocState>(
            builder: (context, state) {
              if (state is CharacterFetchSuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.characterList.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.characterList[index].thumbnail!.path}.${state.characterList[index].thumbnail!.extension}";
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRect(
                          child: Stack(
                            children: [
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                state
                                                    .characterList[index].name!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '${state.characterList[index].name!} appears in  ${state.characterList[index].stories?.available} stories',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                String? wikiUrl = state
                                                    .characterList[index]
                                                    .urls?[2]
                                                    .url;
                                                if (wikiUrl != null) {
                                                  launchUrl(wikiUrl as Uri);
                                                }
                                              },
                                              child: const Text(
                                                'Comics URL',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.7))),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailCharacterScreen(
                                                        characterId: state
                                                            .characterList[
                                                                index]
                                                            .id!,
                                                        nameCharacter: state
                                                            .characterList[
                                                                index]
                                                            .name!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'View details',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
