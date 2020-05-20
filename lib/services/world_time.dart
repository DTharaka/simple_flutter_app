import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location; // location name for the UI
  String time; // Time in that location
  String flag; // URl for the asset flag icon
  String url; // location URL for API endpoint
  bool isDayTime; // True or false is day time or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try {
      //make the requent
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1,3);
      String offset2 = data['utc_offset'].substring(4,6);

      // Create date-time  object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
      
      // Set the time property
      isDayTime = now.hour > 6 &&  now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);  // Using Intl package

    } catch (e) {
        print('Caught an error : $e');
        time = 'Sorry! Could not get time now';
    }
    
  }
}
