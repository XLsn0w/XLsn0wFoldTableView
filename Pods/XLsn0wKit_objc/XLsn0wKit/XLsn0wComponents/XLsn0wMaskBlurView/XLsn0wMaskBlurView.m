
#import "XLsn0wMaskBlurView.h"

@implementation XLsn0wMaskBlurView

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews {
    
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
    
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)superView {
    [superView addSubview:self];
}

- (void)showInKeyWindow {
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

@end
