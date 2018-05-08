//
//  WSTableViewCell.m
//  WSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SuperCell.h"
#import "WSTableViewCellIndicator.h"
#import <Masonry/Masonry.h>
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

#define kIndicatorViewTag -1

@interface SuperCell ()

@end

@implementation SuperCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = NO;
        self.expanded = NO;
        [self customCell];
    }
    return self;
}

- (void)customCell {
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*mas_width);
        make.height.mas_equalTo(50*mas_height);
        make.width.mas_equalTo(50*mas_width);
        make.centerY.mas_equalTo(self);
    }];
    _iconImageView.image = [UIImage imageNamed:@"online"];
    
    
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(15*mas_height);
    }];
    _name.font = [UIFont systemFontOfSize:15];
    _name.textColor = [UIColor blackColor];
    _name.text = @"采集器";
    
    _wifi = [[UIImageView alloc] init];
    [self addSubview:_wifi];
    [_wifi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_name.mas_right).offset(10);
        make.height.mas_equalTo(12*mas_height);
        make.width.mas_equalTo(18*mas_width);
        make.top.mas_equalTo(_name);
    }];
    _wifi.image = [UIImage imageNamed:@"wifi"];
    
    _sn = [[UILabel alloc] init];
    [self addSubview:_sn];
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(_name.mas_bottom).offset(10);
    }];
    _sn.font = [UIFont systemFontOfSize:10];
    _sn.textColor = [UIColor blackColor];
    _sn.text = @"1213r343";
    
    
    _time = [[UILabel alloc] init];
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(10*mas_height);
        make.bottom.mas_equalTo(-5*mas_height);
    }];
    _time.font = [UIFont systemFontOfSize:10];
    _time.textColor = [UIColor blackColor];
    _time.text = @"更新于30秒";
    
    
    _arrow = [[UIImageView alloc] init];
    [self addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(12*mas_height);
        make.width.mas_equalTo(18*mas_width);
        make.centerY.mas_equalTo(self);
    }];
    _arrow.image = [UIImage imageNamed:@"arrowDown"];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor xlsn0w_hexString:@"#ECECEC"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(kScreenWidth-15);
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
        _image = [UIImage imageNamed:@"expandableImage"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}

- (void)setExpandable:(BOOL)isExpandable {
    if (isExpandable)
        [self setAccessoryView:[self expandableView]];
    _expandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addIndicatorView
{
    CGPoint point = self.accessoryView.center;
    CGRect bounds = self.accessoryView.bounds;
    
    CGRect frame = CGRectMake((point.x - CGRectGetWidth(bounds) * 1.5), point.y * 1.4, CGRectGetWidth(bounds) * 3.0, CGRectGetHeight(self.bounds) - point.y * 1.4);
    WSTableViewCellIndicator *indicatorView = [[WSTableViewCellIndicator alloc] initWithFrame:frame];
    indicatorView.tag = kIndicatorViewTag;
    [self addSubview:indicatorView];
}

- (void)removeIndicatorView {
    id indicatorView = [self.contentView viewWithTag:kIndicatorViewTag];
    if (indicatorView) {
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}

- (BOOL)containsIndicatorView {
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
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
