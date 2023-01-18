import 'package:cached_network_image/cached_network_image.dart';
import 'package:entertainment/show/domain/model/show.dart';
import 'package:entertainment/show/view_model/show_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
      itemBuilder: (BuildContext context, int index) {
        Show show = widget?.shows[index];
        return Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: show?.downloadUrl ?? '',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${show?.author} $index',
                  ),
                  Text(
                    'RM $index',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    context.read<ShowListViewModel>().toggleFavourite(show?.id);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color:
                        show?.isFavourite == true ? Colors.pink : Colors.grey,
                    size: 24.0,
                  ),
                  label: Text('FAVOURITE'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await Share.share(show.downloadUrl);
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.blueAccent,
                    size: 24.0,
                  ),
                  label: Text('SHARE'),
                ),
                TextButton.icon(
                  onPressed: () {
                    context
                        .read<ShowListViewModel>()
                        .purchaseItem(index, context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  label: Text('PURCHASE'),
                )
              ],
            )
          ],
        ));
      },
    );
  }

  scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 100), curve: Curves.fastOutSlowIn);
  }
}
