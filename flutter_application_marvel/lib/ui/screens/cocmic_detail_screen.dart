import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/comics/comics_bloc.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

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
        Expanded(child: BlocBuilder<ComicsBloc, ComicsState>(
          builder: (context, state) {
            if (state is ComicDetailFetchSucess) {
              return ListView.builder(
                itemCount: state.comic.length,
                itemBuilder: (context, index) {
                  String image =
                      "${state.comic[index].thumbnail!.path}.${state.comic[index].thumbnail!.extension}";
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
                          title: Text(state.comic[index].title!),
                        ),
                        content: Column(
                          children: <Widget>[
                            Text(
                              state.comic[index].description == ""
                                  ? 'No description data'
                                  : state.comic[index].description!,
                            ),
                            Text(
                                'Resource URI: ${state.comic[index].resourceURI!}')
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
        ))
      ],
    );
  }
}
