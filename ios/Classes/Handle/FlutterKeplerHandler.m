//
//  FlutterKeplerHandler.m
//  flutter_kepler
//
//  Created by 吴兴 on 2019/9/10.
//

#import "FlutterKeplerHandler.h"
#import <JDKeplerSDK/JDKeplerSDK.h>
#import <JDKeplerSDK/KeplerApiManager.h>
#import "FlutterKeplerConstKey.h"
#import "FlutterKeplerTools.h"
@implementation FlutterKeplerHandler
//初始化开普勒
- (void)initKepler:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *appKey = call.arguments[@"appKey"];
    NSString *appSecret = call.arguments[@"appSecret"];
//    [[KeplerApiManager sharedKPService]asyncInitSdk:appKey secretKey:appSecret jdInnerLogin:^(UIViewController *currentViewController) {
//        NSLog(@"这是干啥");
//    } sucessCallback:^{
//        result(@{
//                 FlutterKeplerConstKey_ErrorCode:@"0",
//                 FlutterKeplerConstKey_ErrorMessage:@"success",
//                 });
//    } failedCallback:^(NSError *error) {
//        result(@{
//                 FlutterKeplerConstKey_ErrorCode:@"0",
//                 FlutterKeplerConstKey_ErrorMessage:@"success",
//                 });
//    }];
//
    
    [[KeplerApiManager sharedKPService]asyncInitSdk:appKey secretKey:appSecret sucessCallback:^(){
        //
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"success",
                 });
    }failedCallback:^(NSError *error){
        //
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 });
    }];
}
#pragma mark - 实用功能
/**
 *  通过URL打开任意商品页面
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param userInfo    不需要可以传nil  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
 * 禁止传参带入以下符号：   =#%&+?<{}
 *
 */
- (void)keplerPageWithURL:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *url = call.arguments[@"url"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [[KeplerApiManager sharedKPService] openKeplerPageWithURL:url sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}
/**
 *  打开导航页
 */
- (void)keplerNavigationPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openNavigationPage:rootViewController jumpType:jumpType userInfo:userInfo];
}


/**
 *  通过SKU打开Kepler单品页
 *  @param sku              商品SKU
 */
- (void)keplerOpenItemDetailWithSKU:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *sku = call.arguments[@"sku"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openItemDetailWithSKU:sku sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}

//打开订单列表 （支持Native && H5)
- (void)keplerOpenOrderList:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openOrderList:rootViewController jumpType:jumpType userInfo:userInfo];
}

/**
 *  根据搜索关键字打开搜索结果页
 *  @param searchKey        搜索关键字
 */
- (void)keplerOpenSearchResult:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *searchKey = call.arguments[@"searchKey"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openSearchResult:searchKey sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}

/**
 *  打开购物车界面
 */
- (void)keplerOpenShoppingCart:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openShoppingCart:rootViewController jumpType:jumpType userInfo:userInfo];
}





#pragma mark - 辅助功能
//静态化检测更新
- (void)keplerCheckUpdate:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] checkUpdate];
}

//登录授权
- (void)keplerLogin:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [[KeplerApiManager sharedKPService] keplerLoginWithViewController:rootViewController success:^{
        //        哪来的token???
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"success",
                 //                 FlutterKeplerConstKey_Data:@{},
                 });
    } failure:^(NSError *error) {
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 //                 FlutterKeplerConstKey_Data:@{},
                 });
    }];
}

//取消授权并且清除登录态
- (void)keplerCancelAuth:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] cancelAuth];
}


//设置进度条颜色
- (void)setKeplerProgressBarColor:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *color16 = call.arguments[@"color"];
    if(![FlutterKeplerTools isNil:color16]){
        UIColor *color = [FlutterKeplerTools colorWithHexString:color16];
        [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:color];
    }
}

//检测登录态
- (void)keplerLoginWithSuccess:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] keplerLoginWithSuccess:^{
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"登录有效",
                 });
    } failure:^{
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"-1",
                 FlutterKeplerConstKey_ErrorMessage:@"登录失效",
                 });
    }];
}

// 是否强制使用H5打开界面 默认为YES;设置为NO时,调用商品详情页,订单列表,购物车等方法时将跳转到京东app并打开对应的界面.
- (void)setKeplerOpenByH5:(FlutterMethodCall *)call result:(FlutterResult)result {
    [KeplerApiManager sharedKPService].isOpenByH5 = [call.arguments[@"isOpenByH5"] boolValue];
}

//打开京东后显示的返回按钮的tagID
- (void)setKeplerJDappBackTagID:(FlutterMethodCall *)call result:(FlutterResult)result {
    [KeplerApiManager sharedKPService].JDappBackTagID = call.arguments[@"JDappBackTagID"];
}



//错误码判断
- (NSString *)errorMessageFromCode:(NSInteger)errorCode{
    switch (errorCode) {
        case 0:
            return @"success";
            break;
        case 30001:
            return @"SKU类型无效";
            break;
        case 30002:
            return @"未找到SKU";
            break;
        case 30003:
            return @"加入购物车失败";
            break;
        case 30004:
            return @"绑定用户参数有误";
            break;
        case 30008:
            return @"加车参数有误";
            break;
        case 30009:
            return @"查询所有sku失败";
            break;
        case 30010:
            return @"请求接口参数缺失";
            break;
        case 30012:
            return @"IP参数格式有误";
            break;
        case 30013:
            return @"DeviceType参数格式有误";
            break;
        case 30014:
            return @"UniodID有误";
            break;
        default:
            return @"未知错误";
            break;
    }
}
@end
