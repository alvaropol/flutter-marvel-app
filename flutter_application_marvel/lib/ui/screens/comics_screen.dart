import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/ui/screens/cocmic_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_marvel/blocs/comics/comics_bloc.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository_impl.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ComicsScreen extends StatefulWidget {
  const ComicsScreen({super.key});

  @override
  State<ComicsScreen> createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  int offset = 0;
  late ComicRepository comicRepository;
  late ComicsBloc _comicsBloc;

  @override
  void initState() {
    super.initState();
    comicRepository = ComicRepositoryImpl();
    _comicsBloc = ComicsBloc(comicRepository)..add(ComicsFetchList(offset));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _comicsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comics'),
        ),
        body: _comicList(),
      ),
    );
  }

  Widget _comicList() {
    return Column(
      children: [
        if (offset != 0)
          ElevatedButton(
              onPressed: () {
                setState(() {
                  offset -= 20;
                });
                _comicsBloc = ComicsBloc(comicRepository)
                  ..add(ComicsFetchList(offset));
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
              _comicsBloc = ComicsBloc(comicRepository)
                ..add(ComicsFetchList(offset));
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black)),
            child: const Text('Show next characters',
                style: TextStyle(color: Colors.white))),
        Expanded(
          child: BlocBuilder<ComicsBloc, ComicsState>(
            builder: (context, state) {
              if (state is ComicsFetchSucess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.comicsList.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.comicsList[index].thumbnail!.path}.${state.comicsList[index].thumbnail!.extension}";
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          height: 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.comicsList[index].title!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Flexible(
                                            child: Text(
                                              '${state.comicsList[index].title} appears in  ${state.comicsList[index].stories?.available} stories',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            String? wikiUrl = state
                                                .comicsList[index].urls[2].url;
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.7),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComicDetailScreen(
                                                    comicId: state
                                                        .comicsList[index].id!,
                                                    comicTitle: state
                                                        .comicsList[index]
                                                        .title!,
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is ComicsFetchError) {
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
