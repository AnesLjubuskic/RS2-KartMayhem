import 'dart:convert';

import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class StazeProvider extends BaseProvider<Staze> {
  static String? _baseUrl;
  StazeProvider() : super("Staze") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Staze fromJson(data) {
    return Staze.fromJson(data);
  }

  Future<SearchResult<Staze>> getFavourite({dynamic search}) async {
    var url = "$_baseUrl" "Staze/favouriteTracks";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Staze>();
      result.count = data['count'];
      result.totalCount = data['totalCount'];
      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<bool> MarkFavouriteTrack({dynamic search}) {
    var url = "$_baseUrl" "Staze/markFavouriteTrack";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!.put(uri, headers: headers).then((response) {
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body);
          throw Exception("${data["errors"]["stazeError"][0].toString()}");
        }

        throw Exception('Something went wrong!');
      }
    });
  }
}
