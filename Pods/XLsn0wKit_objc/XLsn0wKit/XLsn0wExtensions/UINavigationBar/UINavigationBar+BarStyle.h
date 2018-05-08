
#import <UIKit/UIKit.h>

@interface UINavigationBar (BarStyle)

/** 设置导航栏背景颜色*/
- (void)style_setNavigationBarBackgroundColor:(UIColor *)color;

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)style_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)style_setNavigationBarVerticalOffsetY:(CGFloat)offsetY;

/**
 重置还原NavigationBar
 */
- (void)style_resetNavigationBar;

@end

///关键代码
/*

 // 改变导航栏颜色对应的透明度
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 CGFloat offsetY = scrollView.contentOffset.y;
 // 除数表示 -> 导航栏从完全透明到完全不透明的过渡距离
 CGFloat alpha = (offsetY - NAVBARCOLOR_CHANGE_POINT) / 64;
 
 if (offsetY > NAVBARCOLOR_CHANGE_POINT) {
 [self.navigationController.navigationBar wr_setBackgroundColor:[MainNavBarColor colorWithAlphaComponent:alpha]];
 }
 else
 {
 [self.navigationController.navigationBar wr_setBackgroundColor:[UIColor clearColor]];
 }
 }










*/
