
#import "XLsn0wNavViewController.h"

@implementation XLsn0wNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavigationBarUI];
}

#pragma mark - draw NavigationBar UI

/*! 绘制XLNavViewController NavigationBarUI */
- (void)drawNavigationBarUI {
    if(self.navigationController.viewControllers.count > 1){
        [self drawNavigationBarBackButton];
    }
    [self setNavigationBarNeedsDisplay];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - set NavigationBar NeedsDisplay

/*! 重新绘制 navigationBar */
- (void)setNavigationBarNeedsDisplay {
    self.navigationController.navigationBar.barTintColor = [self setNavBarBackgroundColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[self setNavBarTitleColor]}];
}

#pragma mark - NavigationBar 返回(左侧)按钮

/*! 绘制NavigationBar 返回按钮 */
- (void)drawNavigationBarBackButton {
    self.navBackButton = [self drawNavBackButton];
    if(!self.navBackButton){
        self.navBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.navBackButton.frame = CGRectMake(0.0, 0.0, 44.0, 44.0);
        /*! 自定义返回按钮 设置成图片 */
        [self.navBackButton setImage:[UIImage imageNamed:@"navBackButton"] forState:(UIControlStateNormal)];
        self.navBackButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -16.0, 0.0, 16.0);
    }
    [self.navBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBackButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

/*! navigationBar 返回事件方法 */
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/*! 子类重绘返回按钮 */
- (UIButton *)drawNavBackButton {
    return nil;
}

#pragma mark - NavgatinBar 颜色

/*! 处理NavgatinBar 背景色 */
- (UIColor *)setNavBarBackgroundColor {
    return [UIColor blueColor];
}

/*! 处理NavigationBar 标题颜色 */
- (UIColor *)setNavBarTitleColor {
    return [UIColor whiteColor];
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
