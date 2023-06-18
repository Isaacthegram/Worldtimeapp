import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  bool isDaytime = true; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    // make the request
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    print(response.body);
    Map data = jsonDecode(response.body);
    //print('data');

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'];
    // print(datetime);
    // print(offset);

    // create DateTime object
    print(datetime);
    // DateTime now = DateTime.parse(datetime.split('+').first);
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset.split(':').first)));
    print(now);

    // set the time property
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);

  }

}

