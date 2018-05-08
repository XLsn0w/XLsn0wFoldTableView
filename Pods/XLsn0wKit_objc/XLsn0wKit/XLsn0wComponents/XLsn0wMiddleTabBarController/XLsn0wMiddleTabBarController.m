
#import "XLsn0wMiddleTabBarController.h"
#import "XLsn0wMiddleTabBar.h"
#import "XLsn0wKitNavigationController.h"

#define kTabbarHeight 49

@interface XLsn0wMiddleTabBarController () <XLsn0wMiddleTabBarDelegate>

@end

@implementation XLsn0wMiddleTabBarController
//+ (void)initialize {
//    // 设置tabbarItem的普通文字
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
//    
//    
//    //设置tabBarItem的选中文字颜色
//    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[NSForegroundColorAttributeName] = BXColor(51, 135, 255);
//    
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
    // 添加所有子控制器
    [self addAllChildVc];
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar {
    XLsn0wMiddleTabBar *tabBar = [[XLsn0wMiddleTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];// 更换tabBar
    tabBar.delegate = self;
    [tabBar.middleButton setTitle:@"XL" forState:(UIControlStateNormal)];
}

- (void)hookMiddleButtonEventWithMiddleButton:(UIButton *)middleButton {
    NSLog(@"middleButton");
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVc {
    // 添加初始化子控制器 BXHomeViewController
    UIViewController *home = [[UIViewController alloc] init];
    [self addOneChildVC:home title:@"首页" imageName:@"tabBar_icon_schedule_default" selectedImageName:@"tabBar_icon_schedule"];
    
    UIViewController *customer = [[UIViewController alloc] init];
    [self addOneChildVC:customer title:@"新闻" imageName:@"tabBar_icon_customer_default" selectedImageName:@"tabBar_icon_customer"];
    
    // 添加一个空白控制器
    [self addChildViewController:[[UIViewController alloc] init]];
    
    UIViewController *compare = [[UIViewController alloc] init];
    [self addOneChildVC:compare title:@"发现" imageName:@"tabBar_icon_contrast_default" selectedImageName:@"tabBar_icon_contrast"];
    
    UIViewController *profile = [[UIViewController alloc]init];
    [self addOneChildVC:profile title:@"我的" imageName:@"tabBar_icon_mine_default" selectedImageName:@"tabBar_icon_mine"];
}


/**
 *  添加一个自控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    XLsn0wKitNavigationController *nav = [[XLsn0wKitNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
