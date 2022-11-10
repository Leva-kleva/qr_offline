import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:finodays/pages.dart';

import 'package:finodays/data.dart';


class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  _GenerateQrCodeState createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  // TextEditingController urlController = TextEditingController();
  // String qrCodeResult = "Not Yet Scanned";


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
            SizedBox(height: 70),
            QrImage(
              data: SendVolume.toString(),
              size: 250,
            ),
            SizedBox(height: 10),
            Text(
              "Перевод " + SendVolume.toString() + " руб.",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
            ),

            SizedBox(height: 70),
            Text(
                "Подтвердить платеж?",
                style: TextStyle(fontSize: 25), textAlign: TextAlign.center
            ),

            SizedBox(height: 10),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    VirtualCash = VirtualCash - SendVolume;
                    Navigator.pop(context);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessPage()),
                  );
                  },
                child: Text('                    Да                    ')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                  },
                child: Text('                    Нет                   ')),
          ],
        ),
      ),
    );
  }
}

