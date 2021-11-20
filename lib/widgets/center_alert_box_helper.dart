import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildCenterAlertBox(_imageToDisplay, _deviceSize, _textToDisplay, _agreeBtnTxt,
    _doOnAgree, _denyBtnTxt, _doOnDeny) {
  return Container(
      width: _deviceSize.width * 0.8,
      padding: EdgeInsets.all(15),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.green, width: 4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset('assets/images/logo2.png'),
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
