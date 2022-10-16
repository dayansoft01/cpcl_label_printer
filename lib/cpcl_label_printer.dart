import 'alignment.dart';
import 'cpcl_label_printer_platform_interface.dart';

class CpclLabelPrinter {
  Future<String?> getPlatformVersion() {
    return CpclLabelPrinterPlatform.instance.getPlatformVersion();
  }

  Future<bool> connect(String name, String address) {
    return CpclLabelPrinterPlatform.instance.connect(name, address);
  }

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
    await CpclLabelPrinterPlatform.instance.drawMultilineText(
      textX: textX,
      textY: textY,
      width: width,
      height: height,
      text: text,
      fontSize: fontSize,
      rotate: rotate,
      bold: bold,
    );
  }

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
    await CpclLabelPrinterPlatform.instance.drawText(
      textX: textX,
      textY: textY,
      text: text,
      fontSize: fontSize,
      rotate: rotate,
      bold: bold,
    );
  }

  /// 发送通用打印命令，drawText等方法也是调用的该方法
  Future portSendCmd(String command) async {
    await CpclLabelPrinterPlatform.instance.portSendCmd(command);
  }

  ///对齐方式
  Future align(CpclPrintAlignment alignment) async {
    await CpclLabelPrinterPlatform.instance.align(alignment);
  }

  ///是否已经连接到打印机
  Future<bool> isConnected() async {
    return await CpclLabelPrinterPlatform.instance.isConnected();
  }

  ///设置纸张大小
  Future pageSetup(int pageWidth, int pageHeight) async {
    await CpclLabelPrinterPlatform.instance.pageSetup(pageWidth, pageHeight);
  }

  ///设置纸张大小
  Future feed() async {
    await CpclLabelPrinterPlatform.instance.feed();
  }

  ///页模式下打印
  Future print(int horizontal, int skip) async {
    await CpclLabelPrinterPlatform.instance.print(horizontal, skip);
  }

  Future test() {
    return CpclLabelPrinterPlatform.instance.test();
  }
}
