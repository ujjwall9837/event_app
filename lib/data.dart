class Event {
  String title;
  String topic;
  String speaker;
  String image;
  int time;
  String place;

  Event(
      this.title, this.topic, this.speaker, this.image, this.time, this.place);
}

List<Event> getEvents() {
  return <Event>[
    Event('Party Flyer', 'Music Challenge', '3Rd Year Students',
        'assets/images/music1.jpg', 9, 'OAT'),
    Event('College Night', 'Concert ', 'King', 'assets/images/music2.jpg', 10,
        'Football Ground'),
    Event('Glow In The Dark', 'Open Mic', 'Students',
        'assets/images/music3.jpg', 11, 'LT2'),
    Event('Centric Hackathon', 'Ethical Hacking', 'anuj',
        'assets/images/hack1.jpg', 5, 'ComputerLab'),
    Event('Kendern', 'Competetive Programming', 'Students',
        'assets/images/hack2.jpg', 6, 'ComputerLAb2 '),
    Event('Global', 'Web Development', 'CICE CLUB', 'assets/images/hack3.jpg',
        7, 'LT1'),
    Event('Crewwz', 'Dance Performance', ' Students', 'assets/images/dance.jpg',
        8, ' OAT'),
    Event('Atrangi', 'Dance Competiton', 'anuj', 'assets/images/dance2.jpg', 4,
        'OAT'),
  ];
}
