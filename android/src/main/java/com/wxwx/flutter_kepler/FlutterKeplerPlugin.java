package com.wxwx.flutter_kepler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterKeplerPlugin */
public class FlutterKeplerPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private MethodChannel channel;
  private static com.wxwx.flutter_kepler.FlutterKeplerHandle handle;


  @Override
  public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
    handle = FlutterKeplerHandle.getInstance();
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_kepler");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    handle = null;
  }

  ///activity 生命周期
  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    handle.setActivity(activityPluginBinding.getActivity());
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    handle.setActivity(null);
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    handle.setActivity(activityPluginBinding.getActivity());
  }

  @Override
  public void onDetachedFromActivity() {
    handle.setActivity(null);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("initKepler")){
      handle.initKepler(call, result);
    }else if(call.method.equals("keplerLogin")){
      handle.keplerLogin(result);
    }else if(call.method.equals("keplerIsLogin")){
      handle.keplerIsLogin(call, result);
    }else if(call.method.equals("keplerCancelAuth")){
      handle.keplerCancelAuth(call, result);
    } else if(call.method.equals("keplerPageWithURL")){
      handle.openJDUrlPage(call, result);
    } else if(call.method.equals("keplerNavigationPage")){
      handle.keplerNavigationPage(call, result);
    } else if(call.method.equals("keplerOpenItemDetailWithSKU")){
      handle.keplerOpenItemDetail(call, result);
    } else if(call.method.equals("keplerOpenOrderList")){
      handle.keplerOpenOrderList(call, result);
    } else if(call.method.equals("keplerOpenSearchResult")){
      handle.keplerOpenSearchResult(call, result);
    } else if(call.method.equals("keplerOpenShoppingCart")){
      handle.keplerOpenShoppingCart(call, result);
    } else if(call.method.equals("keplerFastPurchase")){
      handle.keplerFastPurchase(call, result);
    } else if(call.method.equals("keplerCheckUpdate")){
      handle.keplerCheckUpdate(call, result);
    } else if(call.method.equals("setKeplerProgressBarColor")){
      handle.setKeplerProgressBarColor(call, result);
    } else if(call.method.equals("setKeplerOpenByH5")){
      handle.setKeplerOpenByH5(call, result);
    } else if(call.method.equals("setKeplerJDappBackTagID")){
      handle.setKeplerJDappBackTagID(call, result);
    } else {
      result.notImplemented();
    }
  }
}
