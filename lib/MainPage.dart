import 'package:flutter/material.dart';
import 'package:flutter_application_kobisdb/api.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

DateTime now = DateTime.now();
DateTime yesterday = now.subtract(const Duration(days: 1));

class _MainPageState extends State<MainPage> {
  var controller = TextEditingController();

  dynamic body = const Center(
      child: Text(
    'yyyy mm dd(년 월 일) 입력',
    style: TextStyle(fontSize: 40),
  ));

  void serchMovie(String keyword) async {
    MApi movieApi = MApi();
    var movies = movieApi.search(keyword);

    setState(() {
      body = ListView.separated(
          itemBuilder: (context, index) {
            return movieApi(movie: movies[index]);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: movies.length);
    });
  }

  void showSearchPage() async {
    var result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 200,
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              label: const Text('닫기'),
            ),
            TextFormField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  serchMovie(controller.text);
                  Navigator.pop(context);
                },
                child: const Text('검색하기'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showSearchPage,
        child: const Icon(Icons.search),
      ),
    );
  }
}
