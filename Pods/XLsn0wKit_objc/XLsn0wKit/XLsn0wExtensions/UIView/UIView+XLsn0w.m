
#import "UIView+XLsn0w.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@implementation UIView (XLsn0w)

@end

@implementation UIView (XLSeparator)

- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type {
    [self xlsn0w_addSeparatorWithType:type color:nil];
}

- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color {
    switch (type) {
        case ViewSeparatorTypeTop: {
            UIImageView *topLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            [self addSubview:topLine];
            topLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        }
            break;
        case ViewSeparatorTypeLeft: {
            UIImageView *leftLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            [self addSubview:leftLine];
            leftLine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
        }
            break;
        case ViewSeparatorTypeBottom: {
            UIImageView *bottomLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            bottomLine.frame = CGRectMake(0.0, self.frame.size.height - SeparatorWidth, bottomLine.frame.size.width, SeparatorWidth);
            [self addSubview:bottomLine];
            bottomLine.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
        }
            break;
        case ViewSeparatorTypeRight: {
            UIImageView *rightLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            rightLine.frame = CGRectMake(self.frame.size.width - SeparatorWidth, 0.0, SeparatorWidth, rightLine.frame.size.height);
            [self addSubview:rightLine];
            rightLine.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
        }
            break;
        case ViewSeparatorTypeVerticalSide: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeTop color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeBottom color:color];
        }
            break;
        case ViewSeparatorTypeHorizontalSide: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeLeft color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeRight color:color];
        }
            break;
        default: {
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeHorizontalSide color:color];
            [self xlsn0w_addSeparatorWithType:ViewSeparatorTypeVerticalSide color:color];
        }
            break;
    }
}

- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type {
    [self xlsn0w_addALSeparatorWithType:type color:nil];
    
}

- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color {
    switch (type) {
        case ViewSeparatorTypeTop:{
            UIImageView *topLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            topLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:topLine];
            NSArray *hTopContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topLine]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(topLine)];
            NSArray *vTopContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topLine(borderWidth)]"
                                                                              options:0
                                                                              metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                views:NSDictionaryOfVariableBindings(topLine)];
            [self addConstraints:hTopContraints];
            [self addConstraints:vTopContraints];
        }
            break;
        case ViewSeparatorTypeLeft: {
            UIImageView *leftLine = [[self class] xlsn0w_instanceVerticalLine:self.frame.size.height color:color];
            leftLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:leftLine];
            NSArray *hLeftContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftLine(borderWidth)]"
                                                                                 options:0
                                                                                 metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                   views:NSDictionaryOfVariableBindings(leftLine)];
            NSArray *vLeftContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[leftLine]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(leftLine)];
            [self addConstraints:hLeftContraints];
            [self addConstraints:vLeftContraints];
        }
            break;
        case ViewSeparatorTypeBottom: {
            UIImageView *bottomLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:bottomLine];
            NSArray *hBottomContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLine]-0-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(bottomLine)];
            NSArray *vBottomContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(borderWidth)]-0-|"
                                                                                 options:0
                                                                                 metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                   views:NSDictionaryOfVariableBindings(bottomLine)];
            [self addConstraints:hBottomContraints];
            [self addConstraints:vBottomContraints];
        }
            break;
        case ViewSeparatorTypeRight: {
            UIImageView *rightLine = [[self class] xlsn0w_instanceHorizontalLine:self.frame.size.width color:color];
            rightLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:rightLine];
            NSArray *hRightContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightLine(borderWidth)]-0-|"
                                                                              options:0
                                                                              metrics:@{@"borderWidth":@(SeparatorWidth)}
                                                                                views:NSDictionaryOfVariableBindings(rightLine)];
            NSArray *vRightContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[rightLine]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(rightLine)];
            [self addConstraints:hRightContraints];
            [self addConstraints:vRightContraints];
        }
            break;
        case ViewSeparatorTypeVerticalSide: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeTop color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeBottom color:color];
        }
            break;
        case ViewSeparatorTypeHorizontalSide: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeLeft color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeRight color:color];
        }
            break;
        default: {
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeHorizontalSide color:color];
            [self xlsn0w_addALSeparatorWithType:ViewSeparatorTypeVerticalSide color:color];
        }
    }
}

- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type withColor:(UIColor *)color {
    [self xlsn0w_addSeparatorWithType:type color:color];
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width {
    return [self xlsn0w_instanceHorizontalLine:width color:[UIColor lightGrayColor]];
}


+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height {
    return [self xlsn0w_instanceVerticalLine:height color:[UIColor lightGrayColor]];
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width color:(UIColor *)color {
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, SeparatorWidth)];
    line.backgroundColor = color?:[UIColor lightGrayColor];
    return line;
}

+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height color:(UIColor *)color {
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SeparatorWidth, height)];
    line.backgroundColor = color?:[UIColor lightGrayColor];
    return line;
}

+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width andColor:(UIColor *)color {
    return [self xlsn0w_instanceHorizontalLine:width color:color];
}

+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height andColor:(UIColor *)color {
    return [self xlsn0w_instanceVerticalLine:height color:color];
}

@end

@interface UIView ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation UIView (XLMBProgressHUD)

#pragma mark - runtime

- (void)setHud:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, @selector(hud), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)hud {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - methods

- (void)xlsn0w_showMessageHUD:(NSString *)message {
    if(!self.hud)
        self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = [message isKindOfClass:[NSString class]]?message:@"";
    [self.hud setOffset:(CGPointMake(0, -50))];
    self.hud.userInteractionEnabled = NO;
    [self.hud showAnimated:YES];
}

- (void)xlsn0w_removeHUD{
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

#pragma mark - static methods

+ (void)xlsn0w_showMessage:(NSString *)message {
    [self xlsn0w_showMessage:message onParentView:nil];
}

+ (void)xlsn0w_showMessage:(NSString *)message onParentView:(UIView *)parentView {
    if (!parentView) {
        UIWindow *topWindows = [[[UIApplication sharedApplication] windows] lastObject];
        parentView = topWindows;
    }
    MBProgressHUD *messageHud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    messageHud.mode = MBProgressHUDModeText;
    messageHud.label.text = [message isKindOfClass:[NSString class]] ? message : @"";
    [messageHud setOffset:(CGPointMake(0, -50))];
    messageHud.userInteractionEnabled = NO;
    [messageHud hideAnimated:YES afterDelay:1.5f];
}

+ (void)xlsn0w_showDetailMessage:(NSString *)message {
    [self xlsn0w_showDetailMessage:message onParentView:nil];
}

+ (void)xlsn0w_showDetailMessage:(NSString *)message onParentView:(UIView *)parentView {
    if (!parentView) {
        UIWindow *topWindows = [[[UIApplication sharedApplication] windows] lastObject];
        parentView = topWindows;
    }
    MBProgressHUD *messageHud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    messageHud.mode = MBProgressHUDModeText;
    messageHud.label.text = @"提示";
    messageHud.detailsLabel.text = [message isKindOfClass:[NSString class]] ? message : @"";
    [messageHud setOffset:(CGPointMake(0, -50))];
    messageHud.userInteractionEnabled = NO;
    [messageHud hideAnimated:YES afterDelay:1.0f];
}

@end

@implementation UIView (XLScreenshot)

- (UIImage *)xlsn0w_screenshot {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (UIImage *)xlsn0w_screenshotWithOffsetY:(CGFloat)deltaY {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //  KEY: need to translate the context down to the current visible portion of the tablview
    CGContextTranslateCTM(ctx, 0, deltaY);
    [self.layer renderInContext:ctx];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

@end

@implementation UIView (XLCornerRadius)

- (void)xlsn0w_layerBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)xlsn0w_addBorderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius lineColor:(UIColor *)lineColor {
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    if(lineColor){
        self.layer.borderColor = lineColor.CGColor;
        self.layer.borderWidth = SeparatorWidth;
    }
}

- (void)xlsn0w_addCornerRadius:(CGFloat)radius andLineColor:(UIColor *)lineColor {
    [self xlsn0w_addCornerRadius:radius lineColor:lineColor];
}

@end


@implementation UIView (convenience)

-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

//-(BOOL) containsSubViewOfClassType:(Class)class {
//    for (UIView *view in [self subviews]) {
//        if ([view isMemberOfClass:class]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)newSize {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newSize.width, newSize.height);
}

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
    self.frame = CGRectMake(newX, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
    self.frame = CGRectMake(self.frame.origin.x, newY,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight {
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom {
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            self.frame.size.width, newHeight);
}

@end
