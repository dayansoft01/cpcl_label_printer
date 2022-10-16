import 'dart:async';

import 'package:cpcl_label_printer/alignment.dart';
import 'package:cpcl_label_printer/cpcl_label_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _cpclLabelPrinterPlugin = CpclLabelPrinter();

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _cpclLabelPrinterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var devices =
                      await FlutterBluetoothSerial.instance.getBondedDevices();
                  setState(() {
                    this.devices = devices;
                  });
                },
                child: const Text('扫描')),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        onTap: () async {
                          var device = devices[index];
                          if (await _cpclLabelPrinterPlugin.connect(
                              device.name!, device.address)) {
                            setState(() {
                              selectedDevice = devices[index];
                            });
                            return;
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('连接失败')));
                        },
                        title: Text(
                          devices[index].name ?? '',
                        ),
                        trailing:
                            selectedDevice?.address == devices[index].address
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  )
                                : null,
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: devices.length),
            ),
            ElevatedButton(
              onPressed: () async {
                await _cpclLabelPrinterPlugin.pageSetup(580, 800);
                await _cpclLabelPrinterPlugin.align(CpclPrintAlignment.center);
                await _cpclLabelPrinterPlugin.drawText(
                    textX: 240,
                    textY: 10,
                    text: '出库交接单',
                    fontSize: 2,
                    rotate: 0,
                    bold: 0);
                await _cpclLabelPrinterPlugin.print(0, 1);
              },
              child: const Text('自定义打印测试'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _cpclLabelPrinterPlugin.test();
              },
              child: const Text('打印test'),
            ),
          ],
        ),
      ),
    );
  }
}
