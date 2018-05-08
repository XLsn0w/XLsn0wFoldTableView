
#import "UINavigationBar+BarStyle.h"
#import <objc/runtime.h>

static char *kBarBackgroundViewKey = "NavBarBackgroundView";

@interface UINavigationBar ()

@property(nonatomic,strong) UIView *style_backgroundView;

@end

@implementation UINavigationBar (BarStyle)

- (void)setStyle_backgroundView:(UIView *)style_backgroundView {
    objc_setAssociatedObject(self, kBarBackgroundViewKey, style_backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)style_backgroundView {
    return objc_getAssociatedObject(self, kBarBackgroundViewKey);
}

-(void)style_setNavigationBarBackgroundColor:(UIColor *)color{
    
    
    if (!self.style_backgroundView) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]]; //隐藏导航栏底部默认黑线
        
         self.style_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];

        [self.subviews.firstObject insertSubview:self.style_backgroundView atIndex:0];
        
//        UINavigationBar * contentView = self;
//        if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
//            contentView = [self valueForKey:@"contentView"];
//        }
//        [contentView insertSubview:self.style_backgroundView atIndex:0];
        
    }
    
    self.style_backgroundView.backgroundColor = color;

}

-(void)style_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator{
    
    for (UIView *view in self.subviews){
        if (hasSystemBackIndicator == YES){
            // _UIBarBackground对应的view是系统导航栏，不需要改变其透明度
            if (![view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                view.alpha = alpha;
            }
        } else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if (![view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] && ![view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                view.alpha = alpha;
            }
        }
    }
    
//    [[self valueForKey:@"leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//        view.alpha = alpha;
//    }];
//    
//    [[self valueForKey:@"rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//        view.alpha = alpha;
//    }];
//    
//    UIView * backIndicatorView = [self valueForKey:@"backIndicatorView"];
//    
//    UINavigationController * navigationController = [self valueForKey:@"delegate"];
//    if (navigationController.viewControllers.count == 1) {
//        backIndicatorView.alpha = 0;
//    } else {
//        backIndicatorView.alpha = alpha;
//    }
//    
//    UIView * titleView = [self valueForKey:@"titleView"];
//    titleView.alpha = alpha;
//    
//    UINavigationBar * contentView = self;
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
//        contentView = [self valueForKey:@"contentView"];
//    }
//    
//    [contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
//            if (titleView == nil) {
//                obj.alpha = alpha;
//            }
//        }
//    }];

}

-(void)style_setNavigationBarVerticalOffsetY:(CGFloat)offsetY{
    
    UINavigationBar * contentView = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        contentView = [self valueForKey:@"contentView"];
    }
    contentView.transform = CGAffineTransformMakeTranslation(0, offsetY);
    
    offsetY = MIN(offsetY, 0);
    offsetY = MAX(-44, offsetY);
    [self style_setBarButtonItemsAlpha:(44.0 + offsetY) / 44.0 hasSystemBackIndicator:YES];
    
}
-(void)style_resetNavigationBar{
    
    [self.style_backgroundView removeFromSuperview];
    self.style_backgroundView = nil;
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    
    UINavigationBar * contentView = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        contentView = [self valueForKey:@"contentView"];
    }
    contentView.transform = CGAffineTransformMakeTranslation(0, 0);
    contentView.transform = CGAffineTransformIdentity;
    
    [self style_setBarButtonItemsAlpha:1.0 hasSystemBackIndicator:YES];

}
@end








//===================
/**
 "_itemStack",
 "_delegate",
 "_rightMargin",
 "_state",
 "_barBackgroundView",     iOS10
 _backgroundView           iOS8.9
 
 "_customBackgroundView",
 "_titleView",
 "_leftViews",
 "_rightViews",
 "_prompt",
 "_accessoryView",
 "_contentView",        iOS10
 "_currentCanvasView",
 "_barTintColor",
 "_userContentGuide",
 "_userContentGuideLeading",
 "_userContentGuideTrailing",
 "_appearanceStorage",
 "_currentAlert",
 "_navbarFlags",
 "_popSwipeGestureRecognizer",
 "_backIndicatorView",
 "_slideTransitionClippingViews",
 "_navControllerAnimatingContext",
 "_leadingAffordanceView",
 "_trailingAffordanceView",
 "_transitionCoordinator",
 "_needsUpdateBackIndicatorImage",
 "_wantsLetterpressContent",
 "_barPosition",
 "_requestedMaxBackButtonWidth",
 "_accessibilityButtonBackgroundTintColor",
 "__animationIds",
 "_contentFocusContainerGuide"
 
 */
