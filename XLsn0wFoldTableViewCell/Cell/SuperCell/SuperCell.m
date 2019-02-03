
#import "SuperCell.h"
#import "ArrowIndicator.h"
#import <Masonry/Masonry.h>
#import "Masonry.h"

#define kIndicatorViewTag -1

@interface SuperCell ()

@end

@implementation SuperCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = NO;
        self.expanded = NO;
//        self.backgroundColor = [UIColor xlsn0w_hexString:@"#F8F8F8"];
        [self customCell];
    }
    return self;
}

- (void)customCell {
//    @WeakObj(self);
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(45);
        make.centerY.mas_equalTo(self);
    }];
    _iconImageView.image = [UIImage imageNamed:@"collector"];
    
    
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(25);
    }];
    _name.font = [UIFont systemFontOfSize:20];
    _name.textColor = [UIColor blueColor];
    _name.text = @"采集器";
    
    _wifi = [[UIImageView alloc] init];
    [self addSubview:_wifi];
    [_wifi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_name.mas_right).offset(10);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(18);
        make.top.mas_equalTo(self->_name);
    }];
    _wifi.image = [UIImage imageNamed:@"wifi"];
    
    _sn = [[UILabel alloc] init];
    [self addSubview:_sn];
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self->_name.mas_bottom).offset(18);
    }];
    _sn.font = [UIFont systemFontOfSize:14];
    _sn.textColor = [UIColor greenColor];
    _sn.text = @"567895678956789";
    

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(300);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
    }];
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isExpanded) {
        
        if ([self containsIndicatorView]) {
            [self removeIndicatorView];
            [self addIndicatorView];
        }
    }
}

static UIImage *_image = nil;

- (UIView *)expandableView {
    if (!_image) {
        _image = [UIImage imageNamed:@"list"];
    }
    
    UIButton *foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    foldButton.frame = CGRectMake(0.0, 0.0, 40, 40);

    [foldButton setImage:_image forState:UIControlStateNormal];
    
    return foldButton;
}

- (void)setExpandable:(BOOL)isExpandable {
    if (isExpandable) {
        [self setAccessoryView:[self expandableView]];
        _expandable = isExpandable;
    }
}

- (void)addIndicatorView {
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    ArrowIndicator *indicatorView = [[ArrowIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    [self addSubview:indicatorView];
}

- (void)removeIndicatorView {
    id indicatorView = [self viewWithTag:kIndicatorViewTag];
    if (indicatorView) {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView {
    return [self viewWithTag:kIndicatorViewTag] ? YES : NO;
}
///    self.superCellBlock(self.isExpanded, @"xx");
- (void)accessoryViewAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        if (self.isExpanded) {
            
            self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
        if (!self.isExpanded)
            [self removeIndicatorView];
        
    }];
}

@end
