import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  ChooseLocation({Key key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  void initState() {
    super.initState();
  }

  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Colombo', location: 'Colombo', flag: 'srilanka.jpg'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'london.png'),
    WorldTime(url: 'Asia/Singapore', location: 'Singapore', flag: 'singapore.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();

    // navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[200],
       appBar: AppBar(
         backgroundColor: Colors.grey[900],
         title: Text('Choose a Location'),
         elevation: 0,
         centerTitle: true,
       ),
       body: ListView.builder(
         itemCount: locations.length,
         itemBuilder: (context,index){
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
             child: Card(
               child: ListTile(
                 onTap: (){
                   updateTime(index);
                 },
                 title: Text(locations[index].location),
                 leading: CircleAvatar(
                   backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  // backgroundImage: NetworkImage('https://www.countryflags.io/:country_code/:style/:size.png')
                 ),
               )
             ),
           ); 
         },
      ),
    );
  }
}