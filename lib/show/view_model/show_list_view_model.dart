import 'dart:async';

import 'package:entertainment/show/domain/model/show.dart';
import 'package:entertainment/show/domain/service/show_service.dart';
import 'package:entertainment/show/view/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShowListViewModel with ChangeNotifier {
  ShowListViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  List<Show> shows = [];
  num availableCredit = 1000;

  Future init() async {
    try {
      showSpinner();
      shows = await ShowService.getShows();
    } finally {
      hideSpinner();
    }
    notifyListeners();
  }

  toggleFavourite(String id) {
    Show show =
        shows.firstWhere((element) => element.id == id, orElse: () => null);

    if (show.isFavourite == null || show.isFavourite == false) {
      show.isFavourite = true;
    } else {
      show.isFavourite = false;
    }
    notifyListeners();
  }

  purchaseItem(num amount, BuildContext context) {
    if (amount < 0.01) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Reminder'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This product is out of stock. Will update soon'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (amount > availableCredit) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Available Balance is not enough. Please top up'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Confirm to purchase?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('CONFIRM'),
                onPressed: () {
                  availableCredit = availableCredit - amount;

                  notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
