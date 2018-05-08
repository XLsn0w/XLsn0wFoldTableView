
#import "UITabBarController+XLsn0w.h"

@implementation UITabBarController (XLsn0w)

@end

@implementation UITabBarController (NavTabBarItem)

+ (void)addChildNavigationControllerWithRootViewController:(UIViewController *)rootViewController
                                           tabBarItemTitle:(NSString *)title
                                       tabBarItemImageName:(NSString *)imageName
                               tabBarItemSelectedImageName:(NSString *)selectedImageName
                                          tabBarController:(UITabBarController *)tabBarController {
    //init navigationController
    UINavigationController *childNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    //init tabBarItem
    childNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //TabBarController addChildViewController: NavigationController
    [tabBarController addChildViewController:childNavigationController];
}

@end
