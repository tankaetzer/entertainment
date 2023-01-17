import 'package:dio/dio.dart';
import 'package:entertainment/show/domain/model/show.dart';

class ShowService {
  static Future<List<Show>> getShows() async {
    try {
      Response response = await Dio().get('https://picsum.photos/v2/list');

      if (response?.data != null) {
        return response?.data?.map<Show>((e) {
              return Show.fromJson(e);
            })?.toList() ??
            [];
      }
      return [];
    } on DioError catch (e) {
      throw e;
    }
  }
}
