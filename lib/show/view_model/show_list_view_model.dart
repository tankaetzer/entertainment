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

  Future init() async {
    try {
      showSpinner();
      shows = await ShowService.getShows();
    } finally {
      hideSpinner();
    }
    notifyListeners();
  }
}
