import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen>
    with TickerProviderStateMixin {
  List<dynamic> popularBooks = [];
  List<dynamic> allBooksData = [];
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    popularBook();
    allBooks();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future allBooks() async {
    final response =
        await http.get(Uri.parse('https://freetestapi.com/api/v1/books'));
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      setState(() {
        allBooksData = jsonData;

        print(allBooksData);
      });
    }
  }

  Future popularBook() async {
    final response = await http
        .get(Uri.parse('https://freetestapi.com/api/v1/books?limit=5'));
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      setState(() {
        popularBooks = jsonData;
        print(popularBooks);
      });
      // return jsonData;
      // return convert.jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                child: const Text(
                  "Popular Books",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: PageController(initialPage: 0, viewportFraction: 0.8),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(popularBooks[index]['cover_image']),
                        fit: BoxFit.cover)),
              ),
              itemCount: popularBooks.length,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          // backgroundColor: Colors.white,
                          // floating: true,
                          pinned: true,
                          automaticallyImplyLeading: false,
                          // leading:  null,
                          // title: Text("Books",style: TextStyle(color: Colors.black),),
                          centerTitle: true,
                          bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(0),
                                child: TabBar(
                                  indicatorPadding: const EdgeInsets.all(0),
                                  labelPadding: const EdgeInsets.only(left: 10),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 2,
                                            offset: const Offset(0, 0))
                                      ]),
                                  tabs: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 138, 229, 53),
                                      ),
                                      // height: 30,
                                      child: const Text(
                                        'New',
                                        textAlign: TextAlign.center,
                                      ),
                                      //
                                    ),
                                    Container(
                                      height: 40,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(255, 157, 91, 250),
                                      ),
                                      // height: 30,
                                      child: const Text(
                                        'popular',
                                        textAlign: TextAlign.center,
                                      ),
                                      //
                                    ),
                                    Container(
                                      height: 40,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 217, 157, 156),
                                      ),
                                      // height: 30,
                                      child: const Text(
                                        'Trending',
                                        textAlign: TextAlign.center,
                                      ),
                                      //
                                    )
                                  ],
                                  controller: _tabController,
                                ),
                              )),
                        )
                      ],
                  body: TabBarView(controller: _tabController, children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: allBooksData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // padding: EdgeInsets.all(10),
                          margin:
                              const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            allBooksData[index]['cover_image']),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '4.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      allBooksData[index]['title'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      allBooksData[index]['author'],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: const Icon(
                                  Icons.favorite,color: Colors.red,),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: popularBooks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // padding: EdgeInsets.all(10),
                          margin:
                              const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            popularBooks[index]['cover_image']),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '4.0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      popularBooks[index]['title'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      popularBooks[index]['author'],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://i.imgur.com/8bfm4p4.jpeg'),
                        ),
                        title: Text(
                          "content",
                        ),
                      ),
                    ),
                  ])))
        ],
      ),
    );
  }
}
