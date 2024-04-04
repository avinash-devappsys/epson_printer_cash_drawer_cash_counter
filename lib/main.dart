import 'package:epson_printer_cash_drawer_cash_counter/usb_thermal_printer_web.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'application_class.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover Printers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var pairedDevice;

printReceipt() async {
  WebThermalPrinter _printer = WebThermalPrinter();
  //Pairing Device is required.

  if (pairedDevice == null) {
    await _printer.pairDevice(
        vendorId: 0x04b8, productId: 0x0e27, isAlreadyPaired: false);
  } else {
    await _printer.pairDevice(
        vendorId: 0x04b8, productId: 0x0e27, isAlreadyPaired: true);
  }

  pairedDevice = _printer.pairedDevice;

  await _printer.printText('DKT Mart', bold: true, centerAlign: true);
  // await _printer.printEmptyLine();

  // await _printer.printRow("Products", "Sale");
  // await _printer.printEmptyLine();

  // for (int i = 0; i < 1; i++) {
  //   await _printer.printRow(
  //       'A big title very big title ${i + 1}', '${(i + 1) * 510}.00 AED');
  //   await _printer.printEmptyLine();
  // }

  await _printer.printDottedLine();
  await _printer.printEmptyLine();

  await _printer.printBarcode('123456');
  //await _printer.printEmptyLine();

  await _printer.printEmptyLine();
  await _printer.printEmptyLine();
  await _printer.printEmptyLine();
  await _printer.printEmptyLine();
  await _printer.printEmptyLine();

  await _printer.cutPaper();
  // await _printer.openDrawer();
  await _printer.closePrinter();
}

Future<SharedPreferences> getSharedPreferences() async {
  return await SharedPreferences.getInstance();
}

Future<void> saveData(String key, dynamic value) async {
  final prefs = await getSharedPreferences();
  prefs.setString("pairedDevice", pairedDevice.toString());
}

Future<dynamic> readData(String key) async {
  final prefs = await getSharedPreferences();
  final value = prefs.getString(key);
  print("pairedValue: ${ApplicationData().pairedDevice}");
  if (value != null) {
    print(value);
    return value;
  } else {
    print("No saved value in shared Preference!!!!");
  }
  // Check for other data types as needed
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                readData("pairedDevice");
              },
              child: Text("Show"),
            ),
            ElevatedButton(
              onPressed: () {
                printReceipt();
              },
              child: Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
