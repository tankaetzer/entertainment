import 'package:cached_network_image/cached_network_image.dart';
import 'package:entertainment/show/domain/model/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowList extends StatefulWidget {
  const ShowList({Key key, this.shows}) : super(key: key);

  final List<Show> shows;

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget?.shows?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: widget?.shows[index].downloadUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      },
    );
  }
}
