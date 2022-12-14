import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'alignment.dart';
import 'cpcl_label_printer_platform_interface.dart';

/// An implementation of [CpclLabelPrinterPlatform] that uses method channels.
class MethodChannelCpclLabelPrinter extends CpclLabelPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cpcl_label_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> connect(String name, String address) async {
    return await methodChannel.invokeMethod<bool>(
            'connect', <String, dynamic>{"name": name, "address": address}) ??
        false;
  }

  @override
  Future drawMultilineText({
    required int textX,
    required int textY,
    required int width,
    required int height,
    required String text,
    required int fontSize,
    required int rotate,
    required int bold,
    bool underline = false,
    bool reverse = false,
    bool watermark = false,
  }) async {
    await methodChannel.invokeMethod('drawMultilineText', <String, dynamic>{
      'text_x': textX,
      'text_y': textY,
      'width': width,
      'height': height,
      'text': text,
      'fontSize': fontSize,
      'rotate': rotate,
      'bold': bold,
      'underline': underline,
      'reverse': reverse,
      'watermark': watermark,
    });
  }

  @override
  Future drawText({
    required int textX,
    required int textY,
    required String text,
    required int fontSize,
    required int rotate,
    required int bold,
    bool underline = false,
    bool reverse = false,
    bool watermark = false,
  }) async {
    await methodChannel.invokeMethod('drawText', <String, dynamic>{
      'text_x': textX,
      'text_y': textY,
      'text': text,
      'fontSize': fontSize,
      'rotate': rotate,
      'bold': bold,
      'underline': underline,
      'reverse': reverse,
      'watermark': watermark,
    });
  }

  /// ???????????????????????????drawText?????????????????????????????????
  @override
  Future portSendCmd(String command) async {
    await methodChannel
        .invokeMethod('portSendCmd', <String, dynamic>{'command': command});
  }

  ///????????????
  @override
  Future align(CpclPrintAlignment alignment) async {
    await portSendCmd(alignment.value);
  }

  ///??????????????????????????????
  @override
  Future<bool> isConnected() async {
    return await methodChannel.invokeMethod('isConnected');
  }

  ///??????????????????
  @override
  Future pageSetup(int pageWidth, int pageHeight) async {
    await methodChannel.invokeMethod('pageSetup', <String, dynamic>{
      'pageWidth': pageWidth,
      'pageHeight': pageHeight,
    });
  }

  ///??????????????????
  @override
  Future feed() async {
    await methodChannel.invokeMethod('feed');
  }

  ///??????????????????
  @override
  Future print(int horizontal, int skip) async {
    await methodChannel.invokeMethod('print', <String, dynamic>{
      'horizontal': horizontal,
      'skip': skip,
    });
  }

  @override
  Future test() async {
    await methodChannel.invokeMethod('test');
  }
}
