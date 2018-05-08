

#import "XLsn0wAuthorizationManager.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation XLsn0wAuthorizationManager

#pragma mark - 相册
+ (void)requestImagePickerAuthorization:(void(^)(XLsn0wAuthorizationManagerStatus status))callback {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusNotDetermined) { // 未授权
            if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
                [self executeCallback:callback status:AuthorizationStatusAuthorized];
            } else {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusAuthorized) {
                        [self executeCallback:callback status:AuthorizationStatusAuthorized];
                    } else if (status == PHAuthorizationStatusDenied) {
                        [self executeCallback:callback status:AuthorizationStatusDenied];
                    } else if (status == PHAuthorizationStatusRestricted) {
                        [self executeCallback:callback status:AuthorizationStatusRestricted];
                    }
                }];
            }
            
        } else if (authStatus == ALAuthorizationStatusAuthorized) {
            [self executeCallback:callback status:AuthorizationStatusAuthorized];
        } else if (authStatus == ALAuthorizationStatusDenied) {
            [self executeCallback:callback status:AuthorizationStatusDenied];
        } else if (authStatus == ALAuthorizationStatusRestricted) {
            [self executeCallback:callback status:AuthorizationStatusRestricted];
        }
    } else {
        [self executeCallback:callback status:AuthorizationStatusNotSupport];
    }
}

#pragma mark - 相机
+ (void)requestCameraAuthorization:(void (^)(XLsn0wAuthorizationManagerStatus))callback {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self executeCallback:callback status:AuthorizationStatusAuthorized];
                } else {
                    [self executeCallback:callback status:AuthorizationStatusDenied];
                }
            }];
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            [self executeCallback:callback status:AuthorizationStatusAuthorized];
        } else if (authStatus == AVAuthorizationStatusDenied) {
            [self executeCallback:callback status:AuthorizationStatusDenied];
        } else if (authStatus == AVAuthorizationStatusRestricted) {
            [self executeCallback:callback status:AuthorizationStatusRestricted];
        }
    } else {
        [self executeCallback:callback status:AuthorizationStatusNotSupport];
    }
}

#pragma mark - 通讯录
+ (void)requestAddressBookAuthorization:(void (^)(XLsn0wAuthorizationManagerStatus))callback {
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    if (authStatus == kABAuthorizationStatusNotDetermined) {
        __block ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        if (addressBook == NULL) {
            [self executeCallback:callback status:AuthorizationStatusNotSupport];
            return;
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                [self executeCallback:callback status:AuthorizationStatusAuthorized];
            } else {
                [self executeCallback:callback status:AuthorizationStatusDenied];
            }
            if (addressBook) {
                CFRelease(addressBook);
                addressBook = NULL;
            }
        });
        return;
    } else if (authStatus == kABAuthorizationStatusAuthorized) {
        [self executeCallback:callback status:AuthorizationStatusAuthorized];
    } else if (authStatus == kABAuthorizationStatusDenied) {
        [self executeCallback:callback status:AuthorizationStatusDenied];
    } else if (authStatus == kABAuthorizationStatusRestricted) {
        [self executeCallback:callback status:AuthorizationStatusRestricted];
    }
}

#pragma mark - callback
+ (void)executeCallback:(void (^)(XLsn0wAuthorizationManagerStatus))callback status:(XLsn0wAuthorizationManagerStatus)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(status);
        }
    });
}

@end
