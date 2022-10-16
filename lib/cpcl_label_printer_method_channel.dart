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

  /// 发送通用打印命令，drawText等方法也是调用的该方法
  @override
  Future portSendCmd(String command) async {
    await methodChannel
        .invokeMethod('portSendCmd', <String, dynamic>{'command': command});
  }

  ///对齐方式
  @override
  Future align(CpclPrintAlignment alignment) async {
    await portSendCmd(alignment.value);
  }

  ///是否已经连接到打印机
  @override
  Future<bool> isConnected() async {
    return await methodChannel.invokeMethod('isConnected');
  }

  ///设置纸张大小
  @override
  Future pageSetup(int pageWidth, int pageHeight) async {
    await methodChannel.invokeMethod('pageSetup', <String, dynamic>{
      'pageWidth': pageWidth,
      'pageHeight': pageHeight,
    });
  }

  ///设置纸张大小
  @override
  Future feed() async {
    await methodChannel.invokeMethod('feed');
  }

  ///页模式下打印
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
