
#import <UIKit/UIKit.h>

@interface UITabBarController (XLsn0w)

@end

@interface UITabBarController (NavTabBarItem)
/**
 *  @author XLsn0w
 *
 *  封装添加tabbarController控制的navigationController下面的viewController
 *  并设置tabbar的title image selectedImage
 *
 *  @param rootViewController 创建navigationController添加的rootViewController
 *  @param title          显示的名称tabBarItem.title
 *  @param imageName      未被点击显示的tabBarItem.image
 *  @param selectedImageName 被点击tabbar后显示的selectedImageName
 *  @param tabBarController  self 即当前控制器tabBarController
 *
 */
+ (void)addChildNavigationControllerWithRootViewController:(UIViewController *)rootViewController
                                           tabBarItemTitle:(NSString *)title
                                       tabBarItemImageName:(NSString *)imageName
                               tabBarItemSelectedImageName:(NSString *)selectedImageName
                                          tabBarController:(UITabBarController *)tabBarController;

@end
