import 'dart:convert';
import 'package:http/http.dart' as http;

class MApi {
  final apikey = '49e1567a35523dd0715681026c2fc1c0';

  Future<List<dynamic>> search(String keyword) async {
    String site =
        'http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$apikey&targetDt=$keyword';
    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var boxOffice = jsonDecode(response.body)['boxOfficeResult']
          ['dailyBoxOfficeList'] as List<dynamic>;
      return boxOffice;
    } else {
      return [];
    }
  }
}
