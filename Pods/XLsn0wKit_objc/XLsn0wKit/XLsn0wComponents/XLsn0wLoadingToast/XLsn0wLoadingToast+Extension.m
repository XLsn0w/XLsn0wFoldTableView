/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import "XLsn0wLoadingToast+Extension.h"
#import "XLsn0wLoadingToast.h"
#import "XLsn0wKit_objc.h"

@implementation XLsn0wLoadingToast (Extension)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    XLsn0wLoadingToast *hud = [XLsn0wLoadingToast showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:14];
    
    // 设置图片
    UIImage *customImage = [XLsn0w getCustomBundleWithFileName:@"XLsn0wKit_objc" bundleImageName:icon];
    hud.customView = [[UIImageView alloc] initWithImage:customImage];

    // 再设置模式
    hud.mode = XLsn0wLoadingToastModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success" view:view];
}

#pragma mark 显示一些信息
+ (XLsn0wLoadingToast *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    XLsn0wLoadingToast *hud = [XLsn0wLoadingToast showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // YES代表需要蒙版效果
    hud.diXYQackground = YES;
    
    return hud;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (XLsn0wLoadingToast *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideToastForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideToast {
    [self hideToastForView:nil];
}

@end
