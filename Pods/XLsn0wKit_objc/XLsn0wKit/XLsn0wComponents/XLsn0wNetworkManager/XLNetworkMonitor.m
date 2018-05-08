/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *     \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *      \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import "XLNetworkMonitor.h"

#import "XLsn0wLog.h"
#import "AFNetworking.h"
#import "UIView+XLsn0w.h"

@implementation XLNetworkMonitor : NSObject 

static XLNetworkMonitor *instance = nil;
+ (XLNetworkMonitor *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XLNetworkMonitor alloc] init];
    });
    return instance;
}

- (void)startMonitor {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                XLsn0wLog(@"WiFi网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                XLsn0wLog(@"蜂窝网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                XLsn0wLog(@"您的网络已经断开");
                [UIView xlsn0w_showMessage:@"当前网络已断开, 请检查网络设置 !"];
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                XLsn0wLog(@"未知网络");
                [UIView xlsn0w_showMessage:@"未知网络 !"];
                break;
                
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stopMonitor {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
