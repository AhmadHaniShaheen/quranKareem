import 'package:flutter/material.dart';
import 'package:quran_kareem/api/local_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalData localData = LocalData();
  int pageNumber = 2;
  List<dynamic> ayate = [];

  void getLocalData() async {
    ayate = await localData.fetchData(pageNumber);
    setState(() {});
  }

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xffffeec6),
        title: const Text(
          '‏‏‏‏‏‏‏ ‏‏‏‏‏‏',
          style: TextStyle(
            fontFamily: 'hafsSmart',
            fontSize: 24,
            textBaseline: TextBaseline.ideographic,
          ),
        ),
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
            getLocalData();
            return Row(
              textDirection:
                  pageNumber % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: pageNumber % 2 == 0
                            ? const LinearGradient(
                                colors: [
                                  Color(0xffffeec6),
                                  Color(0xfffdfcfa),
                                ],
                              )
                            : const LinearGradient(
                                colors: [
                                  Color(0xfffdfcfa),
                                  Color(0xffffeec6),
                                ],
                              )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: Wrap(
                              children: [
                                for (int i = 0; i < ayate.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${ayate[i]['aya_text']}',
                                      style: const TextStyle(
                                        fontFamily: 'hafsSmart',
                                        fontSize: 24,
                                        textBaseline: TextBaseline.ideographic,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 5,
                  color: Colors.red,
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
