import 'package:flutter/material.dart';
import 'package:quran_kareem/api/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Network network = Network();
  int pageNumber = 1;
  List ayat = [];

  void getData() async {
    Map<String, dynamic> pageData = await network.fetchData(pageNumber);
    setState(() {
      ayat = pageData['data']['ayahs'];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      body: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                  child: Text(
                '$pageNumber',
                style: const TextStyle(
                  fontSize: 18,
                ),
              )),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: SafeArea(child: PageView.builder(
          itemBuilder: (context, index) {
            pageNumber = index + 1;
            getData();
            return Wrap(
              children: [
                for (int i = 0; i < ayat.length; i++)
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${ayat[i]['text']}',
                              style: const TextStyle(
                                fontSize: 18,
                                textBaseline: TextBaseline.ideographic,
                              ),
                            ),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: Container(
                                  width: 30,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/quranicon.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${ayat[i]['numberInSurah']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ],
            );
          },
        )),
      ),
    );
  }
}
