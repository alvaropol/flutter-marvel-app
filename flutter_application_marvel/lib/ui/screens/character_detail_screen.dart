import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/characters/characters_bloc_bloc.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository.dart';
import 'package:flutter_application_marvel/repositories/characters/character_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                                state.character[index].name!,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '${state.character[index].name!} appears in  ${state.character[index].comics?.available} comics',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '${state.character[index].name!} appears in  ${state.character[index].series?.available} series',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: Text(
                                                state.character[index]
                                                            .description ==
                                                        ""
                                                    ? 'No description data'
                                                    : state.character[index]
                                                        .description!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: Text(
                                                'Resource URI: ${state.character[index].resourceURI!}',
                                                style: const TextStyle(
                                                  color: Colors.white,
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
