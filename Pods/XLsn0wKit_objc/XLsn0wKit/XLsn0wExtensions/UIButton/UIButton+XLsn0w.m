
#import "UIButton+XLsn0w.h"

@implementation UIButton (XLsn0w)

@end

@implementation UIButton (BadgeView)

- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue {
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;
    //寻找
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"]) {
                //从原视图上移除
                [subview removeFromSuperview];
                //
                [self addSubview:subview];
                subview.frame = CGRectMake(self.frame.size.width-subview.frame.size.width, 0, subview.frame.size.width, subview.frame.size.height);
                return subview;
            }
        }
    }
    return nil;
}

- (void)xlsn0w_removeBadgeValue {
    //
    for (UIView *subview in self.subviews) {
        NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
            [strClassName isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
            break;
        }
    }
}

- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue andPadding:(CGPoint)point {
    [self xlsn0w_removeBadgeValue];
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = strBadgeValue;
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    tabBar.items = array;
    //search the view
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] ||
                [strClassName isEqualToString:@"_UIBadgeView"]) {
                //remove from the origin view.
                [subview removeFromSuperview];
                
                [self addSubview:subview];
                subview.frame = CGRectMake(self.frame.size.width-subview.frame.size.width - point.x, 0 + point.y, subview.frame.size.width, subview.frame.size.height);
                return subview;
            }
        }
    }
    return nil;
}

@end

@implementation UIButton (XLButtonCenterStyle)

- (void)xlsn0w_centerImageAndTitle:(float)spacing {
    // get the size of the elements here for readability.
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = CGSizeZero;
    
    // fixed the crash when use the `sizeWithAttributes:` methods before iOS 7.0.
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    } else {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED <= 60000)
        titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
#endif
    }
    
    // check if the size.width is more than the frame.size.width
    titleSize = titleSize.width > self.frame.size.width ? CGSizeMake(self.frame.size.width, titleSize.height) : titleSize;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width - (titleSize.width/imageSize.width >= 2));
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
}

- (void)xlsn0w_centerImageAndTitle {
    const int DEFAULT_SPACING = 6.0f;
    [self xlsn0w_centerImageAndTitle:DEFAULT_SPACING];
}

@end

#import "UIImage+XLsn0w.h"

@implementation StretchButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage stretchImageSizeWithName:@"btn_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage stretchImageSizeWithName:@"btn_highlight"] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage stretchImageSizeWithName:@"btn_disable"] forState:UIControlStateDisabled];
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
