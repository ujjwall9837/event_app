import 'package:assignment01135/2ndapi.dart';
import 'package:assignment01135/button.dart';
import 'package:assignment01135/constant.dart';
import 'package:assignment01135/shared.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Event {
  String createdat;
  String name;
  String category;
  String lesson;
  String id;

  Event(
    this.createdat,
    this.name,
    this.category,
    this.lesson,
    this.id,
  );

  String toString() {
    return "createdat : $createdat, name : $name , category :$category , lesson : $lesson , id : $id";
  }
}

class DataPage extends StatefulWidget {
  String displayname;
  DataPage({
    required this.displayname,
  });

  @override
  State<DataPage> createState() => _DataPageState();
}

List data = [];

class _DataPageState extends State<DataPage> {
  List<bool> optionSelected = [true, false, false];
  void fetchCoin() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    final response = await http.get(
        Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/programs'),
        headers: requestHeaders);

    var body = json.decode(response.body)['items'];
    // print(body);

    if (response.statusCode == 200) {
      setState(() {
        data = body;
      });
      print(data);
    } else {
      // print(Event);
      setState(() {
        data = [];
      });
    }
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.backspace,
            color: Colors.black,
          ),
        ),
        title: Text(
          ' Welcome ',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1('College Program List'),
                  buildTextSubTitleVariation1(
                      'Good AfterNoon ${widget.displayname} !'),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Books', 'assets/icons/mic.jpg', 0),
                      SizedBox(
                        width: 8,
                      ),
                      option('Shoes', 'assets/icons/music.png', 1),
                      SizedBox(
                        width: 8,
                      ),
                      option('Jewelery', 'assets/icons/hackathon.png', 2),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 350,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildEvents(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            signInButton(context, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(
                    displayname: widget.displayname,
                  ),
                ),
              );
            }, 'Move To 2nd API'),
            Container(
              child: Icon(Icons.turn_right),
            )
          ],
        ),
      ),
    );
  }

  Widget option(String text, String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          optionSelected[index] = !optionSelected[index];
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: optionSelected[index] ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [kBoxShadow],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                image,
                // color: optionSelected[index] ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

List<Event> getEvents() {
  return <Event>[
    for (int i = 0; i < data.length; i++)
      Event(
        data[i]['createdAt'].toString(),
        data[i]['name'].toString(),
        data[i]['category'].toString(),
        data[i]['lesson'].toString(),
        data[i]['id'].toString(),
      ),
  ];
}

List<Widget> buildEvents() {
  List<Widget> list = [];
  for (var i = 0; i < getEvents().length; i++) {
    list.add(buildEvent(getEvents()[i], i));
  }
  return list;
}

Widget buildEvent(Event event, int index) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      margin: EdgeInsets.only(
          right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
      padding: EdgeInsets.all(16),
      width: 220,
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: event.name,
              child: Column(
                children: [
                  Container(
                    child: buildEventTitle(event.category),
                  ),
                  Container(
                    child: buildTextSubTitleVariation2(event.createdat),
                  ),
                  Icon(
                    Icons.museum,
                    size: 100,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          buildEventTitle(event.name),
          buildTextSubTitleVariation2(event.lesson),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTime(
                event.id.toString(),
              ),
              Icon(Icons.punch_clock)
            ],
          )
        ],
      ),
    ),
  );
}
