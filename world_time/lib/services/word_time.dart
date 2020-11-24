import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // Url to an asset flag icon
  String url; // Location url for api endpoint
  bool isDaytime; // true if day time, false otherwise

  WorldTime({ this.location, this.flag, this.url });

  Future<String> getTime() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String operation = data['utc_offset'].substring(0,1);

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      if (operation == "+") {
        now = now.add(Duration(hours: int.parse(offset)));
      } else {
        now = now.subtract(Duration(hours: int.parse(offset)));
      }

      // Set the time property
      isDaytime = now.hour >  6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch(e) {
      time = null;
    }

    return time;
  }
}