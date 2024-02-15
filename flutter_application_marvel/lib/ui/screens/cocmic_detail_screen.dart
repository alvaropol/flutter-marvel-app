import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/comics/comics_bloc.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicDetailScreen extends StatefulWidget {
  final int comicId;
  final String comicTitle;
  const ComicDetailScreen(
      {super.key, required this.comicId, required this.comicTitle});

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreen();
}

class _ComicDetailScreen extends State<ComicDetailScreen> {
  late ComicRepository comicRepository;
  late ComicsBloc _comic;

  @override
  void initState() {
    super.initState();
    comicRepository = ComicRepositoryImpl();
    _comic = ComicsBloc(comicRepository)..add(ComicFetchDetail(widget.comicId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _comic,
        child: Scaffold(
          appBar: AppBar(title: Text('Detail of ${widget.comicTitle}')),
          body: _comicWidget(),
        ));
  }

  Widget _comicWidget() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: BlocBuilder<ComicsBloc, ComicsState>(
            builder: (context, state) {
              if (state is ComicDetailFetchSucess) {
                return ListView.builder(
                  itemCount: state.comic.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.comic[index].thumbnail!.path}.${state.comic[index].thumbnail!.extension}";
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
                                                state.comic[index].title!,
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
                                                '${state.comic[index].title!} appears in  ${state.comic[index].creators} Creators',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '${state.comic[index].title!} appears in  ${state.comic[index].series?.name} Series',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: Text(
                                                state.comic[index]
                                                            .description ==
                                                        ""
                                                    ? 'No description data'
                                                    : state.comic[index]
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
                                                'Resource URI: ${state.comic[index].resourceURI!}',
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
