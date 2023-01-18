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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      controller: scrollController,
            itemCount: widget?.shows?.length ?? 0,
      cacheExtent: 99999,
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: widget?.shows[index].downloadUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      },
    );
  }

  scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 25), curve: Curves.fastOutSlowIn);
  }
}
