import 'package:entertainment/show/view/show_list.dart';
import 'package:entertainment/show/view_model/show_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShowListViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterEasyLoading(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Show'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text(
                        'RM ${context.watch<ShowListViewModel>().availableCredit}')),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    ShowList(shows: context.watch<ShowListViewModel>().shows),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
