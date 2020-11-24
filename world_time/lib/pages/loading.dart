import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime(WorldTime instance) async {
    await instance.getTime();

    if (instance.time != null) {
      Navigator.pushNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      });
    } else {
      Navigator.pushNamed(context, '/location');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print('Loading init arguments: $data');
    WorldTime instance = WorldTime(location: data['location'], flag: data['flag'], url: data['url']);
    setupWorldTime(instance);

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
