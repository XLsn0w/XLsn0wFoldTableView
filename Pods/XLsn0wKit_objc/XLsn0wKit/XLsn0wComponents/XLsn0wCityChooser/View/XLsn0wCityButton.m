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

#import "XLsn0wCityButton.h"

#import "Masonry.h"

@interface XLsn0wCityButton ()

@property (nonatomic, strong) UILabel *jfLabel;
@property (nonatomic, strong) UIImageView *jfImageView;

@end

@implementation XLsn0wCityButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self titleLabel:frame];
        [self imageView:frame];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.jfLabel.text = title;
    CGRect tempFrame = self.jfLabel.frame;
    tempFrame.size.width = self.frame.size.width - 10;
    self.jfLabel.frame = tempFrame;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.jfLabel.textColor = titleColor;
}

- (void)setImageName:(NSString *)imageName {
    self.jfImageView.image = [UIImage imageNamed:imageName];
}

- (void)titleLabel:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 10, frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    self.jfLabel = label;
}

- (void)imageView:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(7);
        make.height.offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    self.jfImageView = imageView;
}

@end
