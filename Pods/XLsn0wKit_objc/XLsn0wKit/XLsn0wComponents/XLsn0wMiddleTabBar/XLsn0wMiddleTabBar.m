
#import "XLsn0wMiddleTabBar.h"
#import "UIView+Extension.h"

@implementation XLsn0wMiddleTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:_middleButton];
    }
    return self;
}

- (MiddleButton *)middleButton {
    if (!_middleButton) {
        _middleButton = [MiddleButton new];
        [_middleButton setImage:[UIImage imageNamed:@"摄影机图标_点击前"] forState:UIControlStateNormal];
        [_middleButton setImage:[UIImage imageNamed:@"摄影机图标_点击后"] forState:UIControlStateHighlighted];
        [_middleButton addTarget:self action:@selector(middleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_middleButton setTitle:@"相机" forState:(UIControlStateNormal)];
        [_middleButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        
        //外部可以自定义文字
        //[middleTabBar.middleButton setTitle:@"居中" forState:(UIControlStateNormal)];
    }
    return _middleButton;
}

- (void)middleButtonEvent:(UIButton *)middleButton {
    [self.delegater hookMiddleButtonEventWithMiddleButton:middleButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置bigButton的frame
    CGRect rect = self.bounds;
    CGFloat w = rect.size.width / self.items.count - 1;
    self.middleButton.frame = CGRectInset(rect, 2 * w, 0);
    [self bringSubviewToFront:self.middleButton];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    
    // 因为按钮内部imageView突出
    CGPoint newPoint = [self convertPoint:point toView:self.middleButton.imageView];
    
    if ( [self.middleButton.imageView pointInside:newPoint withEvent:event]) { // 点属于按钮范围
        NSLog(@"点属于按钮范围");
        return self.middleButton;
        
    }else{
         NSLog(@"不属于按钮范围");
        return [super hitTest:point withEvent:event];
    }
}

@end

@implementation MiddleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 16;
    self.titleLabel.y = self.height - self.titleLabel.height;
    
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.titleLabel.y - self.imageView.height;
}

@end

