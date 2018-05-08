
#import <UIKit/UIKit.h>

@interface XLsn0wNavViewController : UIViewController <UIGestureRecognizerDelegate>

/*! 子类点语法直接调用 NavBackButton */
@property (nonatomic, strong) UIButton *navBackButton;

#pragma mark - set NavigationBar NeedsDisplay

/*! 重新绘制 NavigationBar */
- (void)setNavigationBarNeedsDisplay;

#pragma mark - NavigationBar 返回(左侧)按钮

/*! 绘制 NavigationBar 返回按钮 */
- (void)drawNavigationBarBackButton;

/*! NavigationBar 返回事件方法 */
- (void)goBack;

/*! 子类重绘返回按钮 */
- (UIButton *)drawNavBackButton;

#pragma mark - NavgatinBar 颜色

/*! 处理NavgatinBar 背景色 */
- (UIColor *)setNavBarBackgroundColor;

/*! 处理NavigationBar 标题颜色 */
- (UIColor *)setNavBarTitleColor;

@end
