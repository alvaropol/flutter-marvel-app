import 'package:flutter/material.dart';
import 'package:flutter_application_marvel/blocs/comics/comics_bloc.dart';
import 'package:flutter_application_marvel/models/comic_detail/comic_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicDetailScreen extends StatefulWidget {
  final int comicId; // ID del cómic para cargar los detalles

  const ComicDetailScreen({Key? key, required this.comicId}) : super(key: key);

  @override
  _ComicDetailScreenState createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  late ComicsBloc _comicsBloc;

  @override
  void initState() {
    super.initState();
    // Aquí puedes inicializar el bloc o cualquier otra lógica para cargar los detalles del cómic
    // Por ejemplo:
    // _comicsBloc = BlocProvider.of<ComicsBloc>(context)..add(ComicDetailFetch(comicId: widget.comicId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comic Detail'),
      ),
      body: BlocBuilder<ComicsBloc, ComicsState>(
        builder: (context, state) {
          if (state is ComicDetailSuccess) {
            // Asume que ComicDetailSuccess es el estado cuando los detalles se han cargado correctamente
            return _buildComicDetail(state.comic);
          } else if (state is ComicsFetchError) {
            return Text(state.errorMessage);
          }
          return CircularProgressIndicator(); // Mostrar un indicador de carga mientras se cargan los datos
        },
      ),
    );
  }

  Widget _buildComicDetail(Comic comic) {
    // Este método construye el widget que muestra los detalles del cómic.
    // Reemplaza 'Comic' con el tipo correcto según tu implementación.
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.network(
                "${comic.thumbnail.path}.${comic.thumbnail.extension}"),
            SizedBox(height: 8),
            Text(comic.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(comic.description ?? 'No description available'),
            // Añade más widgets según necesites para mostrar los detalles del cómic
          ],
        ),
      ),
    );
  }
}
