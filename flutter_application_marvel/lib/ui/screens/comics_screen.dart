import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/ui/screens/cocmic_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:flutter_application_marvel/blocs/comics/comics_bloc.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository.dart';
import 'package:flutter_application_marvel/repositories/comics/comic_repository_impl.dart';
import 'package:getwidget/getwidget.dart';

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
            child: const Text('Return back'),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              offset += 20;
            });
            _comicsBloc = ComicsBloc(comicRepository)
              ..add(ComicsFetchList(offset));
          },
          child: const Text('Show next comics'),
        ),
        Expanded(
          child:
              BlocBuilder<ComicsBloc, ComicsState>(builder: (context, state) {
            if (state is ComicsFetchSucess) {
              return ListView.builder(
                itemCount: state.comicsList.length,
                itemBuilder: (context, index) {
                  String image =
                      "${state.comicsList[index].thumbnail.path}.${state.comicsList[index].thumbnail.extension}";
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: GFCard(
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.start,
                        title: GFListTile(
                          titleText: state.comicsList[index].title,
                        ),
                        content: Text(
                            'Modified: ${state.comicsList[index].modified}'),
                        buttonBar: GFButtonBar(
                          children: <Widget>[
                            GFButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ComicDetailScreen(
                                      comicId: state.comicsList[index].id,
                                      comicTitle: state.comicsList[index].title,
                                    ),
                                  ),
                                );
                              },
                              child: Text('View Details'),
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
          }),
        ),
      ],
    );
  }
}
