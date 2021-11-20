import 'dart:convert';

//import 'package:locationsettingsdemo/widgets/center_alert_box_helper.dart' as alertBoxHelper;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;

    final _availableHeight = _deviceSize.height - _padding.top;

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    buildCenterAlertBox(
                        Icons.add_location,
                        _deviceSize,
                        "Turn on the Location to use the App",
                        "AGREE",
                        _determinePosition,
                        "DENY",
                        denyLocation),
                    SizedBox(height: _availableHeight * 0.05),
                    ElevatedButton(onPressed: () => {}, child: Text("Go Back"))
                  ],
                ))));
  }

  denyLocation() {
    //StatusModel status = StatusModel.fromSystemError(LOCATIIN_DENIED);
  }

  Future<Position> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print(e);
      // CommonPage.showErrorMessage(context, e.toString());
      return Future.error(e);
    }
    return Future.error('Something went wrong');
  }

  static buildCenterAlertBox(_imageToDisplay, _deviceSize, _textToDisplay,
      _agreeBtnTxt, _doOnAgree, _denyBtnTxt, _doOnDeny) {
    return Container(
        width: _deviceSize.width * 0.8,
        padding: EdgeInsets.all(15),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.green, width: 4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(_imageToDisplay, size: 90, color: Colors.green),
            Text(
              _textToDisplay,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(109, 192, 42, 0.7),
              ),
            ),
            if (_doOnAgree != null)
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(109, 192, 42, 0.7),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Color.fromRGBO(109, 192, 42, 0.7))),
                    ),
                  ),
                  onPressed: _doOnAgree,
                  child: Text(_agreeBtnTxt)),
            if (_doOnDeny != null)
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Color.fromRGBO(109, 192, 42, 0.7))),
                    ),
                  ),
                  onPressed: _doOnDeny,
                  child:
                      Text(_denyBtnTxt, style: TextStyle(color: Colors.black))),
          ],
        ));
  }
}
