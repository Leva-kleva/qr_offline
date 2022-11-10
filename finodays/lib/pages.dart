import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:finodays/QrScreen.dart';

import 'package:finodays/data.dart';


TextEditingController InputController = new TextEditingController();


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _GenerateMainPage createState() => _GenerateMainPage();
}

class _GenerateMainPage extends State<MainPage> {
  String GetCash = "0";
  String InputTextTmp = '';

  Future _qrScanner()async{
    var cameraStatues = await Permission.camera.status;
    if(cameraStatues.isGranted){
      String? data = await scanner.scan();
      setState(() {
        GetCash = data!;
        VirtualCash = VirtualCash + int.parse(GetCash);
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    }else{
      var isGrant = await Permission.camera.request();
      if(isGrant.isGranted){
        String? data = await scanner.scan();
        setState(() {
          GetCash = data!;
          VirtualCash = VirtualCash + int.parse(GetCash);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuccessPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Off Pay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Счет: *7890",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "ФИО: Адлер А.А.",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "Остаток средств: " + VirtualCash.toString() + " руб",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            Text(
              "Последнее обновление 30 минут назад",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 70),

            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Введите сумму перевода',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // labelText: 'Введите сумму перевода',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    InputTextTmp = value;
                  });
                },
                controller: InputController,
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  try {
                    setState(() {
                      SendVolume = int.parse(InputTextTmp);
                      if (SendVolume <= 0 || SendVolume > VirtualCash) [
                        throw new FormatException()
                      ];
                      Navigator.pop(context);
                      InputController.clear();
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenerateQrCode()),
                    );
                  } catch (e) {
                    InputController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Error()),
                    );
                  }
                },
                child: Text('Отправить средства')),
            SizedBox(height: 70),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _qrScanner();
                  });
                },
                child: Text('Получить средства')),
          ],
        ),
      ),
    );
  }
}



class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  _GenerateSuccessPage createState() => _GenerateSuccessPage();
}

class _GenerateSuccessPage extends State<SuccessPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Off Pay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            SizedBox(height: 100),
            Text(
              "Платеж совершен",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              "Остаток средств " + VirtualCash.toString() + " руб.",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: Text('OK')),
          ],
        ),
      ),
    );
  }
}


class Error extends StatefulWidget {
  const Error({super.key});

  @override
  _GenerateError createState() => _GenerateError();
}

class _GenerateError extends State<Error> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Off Pay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            SizedBox(height: 10),
            Text(
              "Ошибка",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              "введенные данные некорректны",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: Text('OK')),
          ],
        ),
      ),
    );
  }
}
