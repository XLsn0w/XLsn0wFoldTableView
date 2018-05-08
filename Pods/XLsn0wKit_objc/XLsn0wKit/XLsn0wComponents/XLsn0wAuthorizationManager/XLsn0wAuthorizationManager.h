

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XLsn0wAuthorizationManagerStatus) {
    AuthorizationStatusAuthorized = 0,    // 已授权
    AuthorizationStatusDenied,            // 拒绝
    AuthorizationStatusRestricted,        // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    AuthorizationStatusNotSupport         // 硬件等不支持
};

@interface XLsn0wAuthorizationManager : NSObject

+ (void)requestImagePickerAuthorization:(void(^)(XLsn0wAuthorizationManagerStatus status))callback;
+ (void)requestCameraAuthorization:(void(^)(XLsn0wAuthorizationManagerStatus status))callback;
+ (void)requestAddressBookAuthorization:(void (^)(XLsn0wAuthorizationManagerStatus))callback;

@end
