package cn.dayansoft.cpcl_label_printer;

import androidx.annotation.NonNull;

import com.qr.print.PrintPP_CPCL;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * CpclLabelPrinterPlugin
 */
public class CpclLabelPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private static PrintPP_CPCL printPP_cpcl = new PrintPP_CPCL();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "cpcl_label_printer");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("connect")) {
            result.success(connect(call.argument("name"), call.argument("address")));
        } else if (call.method.equals("drawMultilineText")) {
            printPP_cpcl.drawText(
                    call.argument("text_x"),
                    call.argument("text_y"),
                    call.argument("width"),
                    call.argument("height"),
                    call.argument("text"),
                    call.argument("fontSize"),
                    call.argument("rotate"),
                    call.argument("bold"),
                    call.argument("underline"),
                    call.argument("reverse"),
                    call.argument("watermark")
            );
            result.success(null);
        } else if (call.method.equals("drawText")) {
            printPP_cpcl.drawText(
                    call.argument("text_x"),
                    call.argument("text_y"),
                    call.argument("text"),
                    call.argument("fontSize"),
                    call.argument("rotate"),
                    call.argument("bold"),
                    call.argument("underline"),
                    call.argument("reverse"),
                    call.argument("watermark")
            );
            result.success(null);
        } else if (call.method.equals("portSendCmd")) {
            String command = call.argument("command");
            printPP_cpcl.portSendCmd(command);
            result.success(null);
        } else if (call.method.equals("isConnected")) {
            result.success(printPP_cpcl.isConnected());
        } else if (call.method.equals("pageSetup")) {
            printPP_cpcl.pageSetup(call.argument("pageWidth"), call.argument("pageHeight"));
            result.success(null);
        } else if (call.method.equals("feed")) {
            printPP_cpcl.feed();
            result.success(null);
        } else if (call.method.equals("print")) {
            printPP_cpcl.print(call.argument("horizontal"),call.argument("skip"));
            result.success(null);
        } else if (call.method.equals("test")) {
            test();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    private boolean connect(String name, String address) {
        return printPP_cpcl.connect(name, address);
    }


    private void test() {
        printPP_cpcl.pageSetup(586, 800);
        printPP_cpcl.drawText(2 + 20, 8, "210-123-000", 3, 0, 0, false, false);
        printPP_cpcl.drawText(2 + 20, 68, "测试一下尝尝文字测试一下尝尝文字测试一下尝尝文字测试一下尝尝文字测试一下尝尝文字测试一下尝尝文字", 3, 0, 0, false, false);
        printPP_cpcl.drawText(2 + 20, 148, "test123fwerwrfwertest123fwerwrfwertest123fwerwrfwertest123fwerwrfwer", 3, 0, 0, false, false);
        printPP_cpcl.drawText(2 + 20, 300, 500, 136, "鞋子、衣服、鞋子、衣服、鞋子、衣服、鞋子、衣服、鞋子、衣服、鞋子、衣服、", 2, 0, 0, false, false);
        printPP_cpcl.print(0, 1);
    }

}
