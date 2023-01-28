import 'package:assignment01135/constant.dart';
import 'package:assignment01135/eventdetails.dart';
import 'package:assignment01135/shared.dart';
import 'package:flutter/material.dart';
import 'package:assignment01135/data.dart';

class EventPage extends StatefulWidget {
  String name;
  EventPage({required this.name});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<bool> optionSelected = [true, false, false];
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
                  buildTextTitleVariation1('College Event List'),
                  buildTextSubTitleVariation1(
                      'Good AfterNoon ${widget.name} !'),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      option('Music', 'assets/icons/mic.jpg', 0),
                      SizedBox(
                        width: 8,
                      ),
                      option('Dance', 'assets/icons/music.png', 1),
                      SizedBox(
                        width: 8,
                      ),
                      option('Hackathon', 'assets/icons/hackathon.png', 2),
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
            Container(
              child: buildTextTitleVariation1("Thank You For Visiting"),
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

  List<Widget> buildEvents() {
    List<Widget> list = [];
    for (var i = 0; i < getEvents().length; i++) {
      list.add(buildEvent(getEvents()[i], i));
    }
    return list;
  }

  Widget buildEvent(Event event, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailPage(event: event)),
        );
      },
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
                tag: event.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(event.image), fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildEventTitle(event.title),
            buildTextSubTitleVariation2(event.topic),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTime(event.time.toString() + " pm"),
                Icon(Icons.punch_clock)
              ],
            )
          ],
        ),
      ),
    );
  }
}
