// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:cointicker/coin_data.dart';
import 'package:cointicker/ios.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool isConnected = false;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  bool isWaiting = false;
  String? coinValue;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getData(selectedCurrency);
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    startStreaming();
    CheckInternet();
    // getConnectivity();
  }

  CheckInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
      getData();
    } else {
      isConnected = false;
      showDialogBox();
    }
  }

  showDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
              title: Text('No Connection'),
              content: Text('Please check your internet Connection'),
              actions: [
                CupertinoButton.filled(
                    child: Text('Retry'),
                    onPressed: () {
                      Navigator.pop(context);
                      CheckInternet();
                    })
              ],
            ));
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      CheckInternet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $coinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $coinValue  $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $coinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: Platform.isIOS ? IOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}




  // late StreamSubscription subscription;
  // var isDeviceConnected = false;
  // bool isAlertSet = false;


  // getConnectivity() {
  //   subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) async {
  //     isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //     if (!isDeviceConnected && isAlertSet == false) {
  //       showDialogBox();
  //       setState(
  //         () => isAlertSet = true,
  //       );
  //     }
  //   });
  // }

  // showDialogBox() => showCupertinoDialog<String>(
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: const Text('No Connection'),
  //         content: const Text('Please check your internet connection'),
  //         actions: <Widget>[
  //           TextButton(
  //               onPressed: () {
  //                 setState(() async {
  //                   isAlertSet = false;
  //                   isDeviceConnected =
  //                       await InternetConnectionChecker().hasConnection;
  //                   if (!isDeviceConnected) {
  //                     showDialogBox();
  //                     setState(() => isAlertSet = true);
  //                   }
  //                 });
  //               },
  //               child: const Text('OK')),
  //         ],
  //       ),
  //       context: context,
  //     );