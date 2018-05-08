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

#import "UINavigationController+AddXLsn0wShouldAutorotate.h"

#import "UIViewController+AddIsAutorotate.h"

@implementation UINavigationController (AddXLsn0wShouldAutorotate)

- (BOOL)shouldAutorotate {
    return [self xlsn0w_shouldAutorotate];
}

- (BOOL)xlsn0w_shouldAutorotate {
    UIViewController *topVC = [self.viewControllers lastObject];
    return topVC.isAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

@end
