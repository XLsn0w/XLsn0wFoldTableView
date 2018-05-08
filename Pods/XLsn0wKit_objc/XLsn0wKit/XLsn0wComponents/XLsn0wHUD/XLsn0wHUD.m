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

#import "XLsn0wHUD.h"

#import "XLsn0wTextHUD.h"
#import "XLsn0wLoadHUD.h"

static NSMutableArray *HUDArray;

@interface XLsn0wHUD () <XLsn0wHUDDelegate> {
    CALayer *_animationLayer;
}

@end

@implementation XLsn0wHUD

+ (void)load {
    HUDArray = [NSMutableArray array];
}

+ (instancetype)showLoadText:(NSString *)loadText superview:(UIView *)superview animated:(BOOL)animated {
    XLsn0wHUD *HUD = [[XLsn0wLoadHUD alloc] initWithFrame:superview.bounds];
    HUD.selfView = superview;
    HUD.text = loadText;
    
    [HUD addIndicator];
    [HUD addText];
    [HUD compositeElements];
    
    [HUD show:animated withDuration:0 completion:nil];
    
    return HUD;
}

+ (instancetype)showTipText:(NSString *)tipText superview:(UIView *)superview duration:(NSTimeInterval)duration animated:(BOOL)animated {
    XLsn0wHUD *HUD = [[XLsn0wTextHUD alloc] initWithFrame:superview.bounds];
    HUD.selfView = superview;
    HUD.text = tipText;
    
    [HUD addText];
    [HUD compositeElements];
    
    [HUD show:animated withDuration:duration completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD dismiss:animated];
        });
    }];
    
    return HUD;
}

+ (void)dismissSuperview:(UIView *)superview animated:(BOOL)animated {
    for (XLsn0wHUD *HUD in HUDArray) {
        if ([HUD.selfView isEqual:superview]) {
            [HUD dismiss:animated];
        }
    }
}

+ (void)dismissAll:(BOOL)animated {
    for (XLsn0wHUD *HUD in HUDArray) {
        [HUD dismiss:animated];
    }
}

- (void)dismiss:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *view in self.subviews) {
                view.alpha = 0;
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [HUDArray removeObject:self];
        }];
    }
    else {
        [self removeFromSuperview];
        [HUDArray removeObject:self];
    }
}

- (void)show:(BOOL)animated withDuration:(NSTimeInterval)duration completion:(void (^)(void))completion {
    [self addSubview:self.backView];
    [HUDArray addObject:self];
    
    if (animated) {
        self.alpha = 0;
        [self.selfView addSubview:self];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (completion != NULL) {
                completion();
            }
        }];
    }
    else {
        [self.selfView addSubview:self];
    }
}

///支付成功

static CGFloat lineWidth = 4.0f;
static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;

#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]

//显示
+ (XLsn0wHUD *)showPayIn:(UIView*)view {
    [self hidePayIn:view];
    XLsn0wHUD *hud = [[XLsn0wHUD alloc] initWithFrame:view.bounds];
    [hud startPay];
    [view addSubview:hud];
    return hud;
}

//隐藏
+ (XLsn0wHUD *)hidePayIn:(UIView *)view {
    XLsn0wHUD *hud = nil;
    for (XLsn0wHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[XLsn0wHUD class]]) {
            [subView hidePay];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

- (void)startPay {
    [self circleAnimation];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.8 * circleDuriation * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self checkAnimation];
    });
}

- (void)hidePay {
    for (CALayer *layer in _animationLayer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _animationLayer = [CALayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self.layer addSublayer:_animationLayer];
}

//画圆
- (void)circleAnimation {
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = BlueColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    
    
    CGFloat lineWidth = 5.0f;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = circleDuriation;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.delegate = self;
    [circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:circleAnimation forKey:nil];
}

//对号
- (void)checkAnimation {
    
    CGFloat a = _animationLayer.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = BlueColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = checkDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

@end


