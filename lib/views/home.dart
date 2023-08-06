import 'package:flutter/material.dart';
import 'package:quran_kareem/api/local_data.dart';
import 'package:quran_kareem/models/ayah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalData localData = LocalData();
  List<List<Ayah>>? pages;
  int pageNumber = 3;

  void getLocalData() async {
    pages = await localData.fetchData(pageNumber);
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
      body: pages == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
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
              child: SafeArea(
                  child: PageView.builder(
                itemCount: 604,
                onPageChanged: (value) {
                  setState(() {
                    pageNumber = value;
                  });
                },
                itemBuilder: (context, index) {
                  pageNumber = index + 1;
                  getLocalData();
                  Set<String?> surah = {};
                  Set<int?> jozz = {};
                  for (Ayah ayah in pages![index]) {
                    surah.add(ayah.suraNameAr);
                    jozz.add(ayah.jozz);
                    return Row(
                      textDirection: index % 2 == 0
                          ? TextDirection.ltr
                          : TextDirection.rtl,
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
                                  Visibility(
                                    visible: ayah.ayaNo == 1,
                                    child: Container(
                                      width: double.infinity,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/pngtree-head-of-surah.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${ayah.suraNameAr}',
                                          style: const TextStyle(
                                            fontFamily: 'hafsSmart',
                                            fontSize: 18,
                                            textBaseline:
                                                TextBaseline.ideographic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Visibility(
                                    visible: (ayah.ayaNo == 1 &&
                                            ayah.suraNameAr != "الفَاتِحة" &&
                                            ayah.suraNameAr != "التوبَة")
                                        ? true
                                        : false,
                                    child: const Text(
                                      '‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏',
                                      style: TextStyle(
                                        fontFamily: 'hafsSmart',
                                        fontSize: 24,
                                        textBaseline: TextBaseline.ideographic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Flexible(
                                    child: Wrap(
                                      children: [
                                        for (Ayah ayah in pages![index])
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '${ayah.ayaText}',
                                                  style: const TextStyle(
                                                    fontFamily: 'hafsSmart',
                                                    fontSize: 18,
                                                    textBaseline: TextBaseline
                                                        .ideographic,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                  }
                  return null;
                },
              )),
            ),
    );
  }
}
