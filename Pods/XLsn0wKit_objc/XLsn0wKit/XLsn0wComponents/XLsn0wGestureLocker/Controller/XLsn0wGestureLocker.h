/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import <UIKit/UIKit.h>
/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
typedef NS_ENUM(NSInteger, GestureType) {
    CreateGesture,  // 创建手势密码
    CheckGesture    // 校验手势密码
};

@interface XLsn0wGestureLocker : UIViewController

- (instancetype)initWithGestureType:(GestureType)gestureType;///
+ (NSString *)getGesture; //获取手势密码
+ (void)deleteGesture;    //删除手势密码

@end

/*

 
if (indexPath.row == 0) { // 创建手势密码
    XLsn0wGestureLocker *vc = [[XLsn0wGestureLocker alloc] initWithUnlockType:CreateGesture];
    [self presentViewController:vc animated:YES completion:nil];
} else if (indexPath.row == 1) { // 校验手势密码

    if ([XLsn0wGestureLocker getGesture].length > 0) {
        
        XLsn0wGestureLocker *vc = [[XLsn0wGestureLocker alloc] initWithUnlockType:CreateGesture];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"还没有设置手势密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }
} else if (indexPath.row == 2) { // 删除手势密码
    [CreateGesture deleteGesture];
}


*/
