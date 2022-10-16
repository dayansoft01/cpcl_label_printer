import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'alignment.dart';
import 'cpcl_label_printer_method_channel.dart';

abstract class CpclLabelPrinterPlatform extends PlatformInterface {
  /// Constructs a CpclLabelPrinterPlatform.
  CpclLabelPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static CpclLabelPrinterPlatform _instance = MethodChannelCpclLabelPrinter();

  /// The default instance of [CpclLabelPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelCpclLabelPrinter].
  static CpclLabelPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CpclLabelPrinterPlatform] when
  /// they register themselves.
  static set instance(CpclLabelPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  ///连接打印机
  Future<bool> connect(String name, String address) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  ///打印多行文本，需要指定多行文本的最大高度
  ///
  /// [textX] - 起始横坐标
  ///
  /// [textY] - 起始纵坐标
  ///
  /// [width] - 文本框宽度
  ///
  /// [height] - 文本框高度
  ///
  /// [text] - 打印的文本内容
  ///
  /// [fontSize] - 字体大小 1：16点阵； 2：24点阵； 3：32点阵； 4：24点阵放大一倍； 5：32点阵放大一倍 6：24点阵放大两倍； 7：32点阵放大两倍； 8：20点阵； 9：28点阵放大一倍； 其他：16点阵
  ///
  /// [rotate] - 旋转角度 0：不旋转； 1：90度； 2：180°； 3:270°
  ///
  /// [bold] - 是否粗体 0：否； 1：是
  ///
  /// [reverse] - 是否反白 false：不反白；true：反白
  ///
  /// [underline] - 是否有下划线 false：没有；true：有
  ///
  /// [watermark] - 是否为水印 false：否；true：是
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
  }) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  ///打印单行文本
  ///
  /// [textX] - 起始横坐标
  ///
  /// [textY] - 起始纵坐标
  ///
  /// [text] - 打印的文本内容
  ///
  /// [fontSize] - 字体大小 1：16点阵； 2：24点阵； 3：32点阵； 4：24点阵放大一倍； 5：32点阵放大一倍 6：24点阵放大两倍； 7：32点阵放大两倍； 8：20点阵； 9：28点阵放大一倍； 其他：16点阵
  ///
  /// [rotate] - 旋转角度 0：不旋转； 1：90度； 2：180°； 3:270°
  ///
  /// [bold] - 是否粗体 0：否； 1：是
  ///
  /// [reverse] - 是否反白 false：不反白；true：反白
  ///
  /// [underline] - 是否有下划线 false：没有；true：有
  ///
  /// [watermark] - 是否为水印 false：否；true：是
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
  }) {
    throw UnimplementedError('connect() has not been implemented.');
  }

  /// 发送通用打印命令，drawText等方法也是调用的该方法
  Future portSendCmd(String command) {
    throw UnimplementedError('portSendCmd() has not been implemented.');
  }

  ///对齐方式
  Future align(CpclPrintAlignment alignment) {
    throw UnimplementedError('align() has not been implemented.');
  }

  ///是否已经连接到打印机
  Future<bool> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  ///设置纸张大小
  Future pageSetup(int pageWidth, int pageHeight) {
    throw UnimplementedError('pageSetup() has not been implemented.');
  }

  ///设置纸张大小
  Future feed() {
    throw UnimplementedError('feed() has not been implemented.');
  }

  ///页模式下打印
  /// [horizontal] - 0:正常打印，不旋转； 1：整个页面顺时针旋转180°后，再打印
  /// [skip] - 0：打印结束后不定位，直接停止； >0：打印结束后定位到标签分割线，如果无缝隙，最大进纸skip个dot后停止(1mm==8dot)
  /// 返回:
  /// ok:打印成功 Invalid Device：不支持该设备
  Future print(int horizontal, int skip) {
    throw UnimplementedError('print() has not been implemented.');
  }

  Future test() {
    throw UnimplementedError('test() has not been implemented.');
  }
}
