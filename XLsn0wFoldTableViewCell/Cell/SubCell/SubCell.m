
#import "SubCell.h"
#import <Masonry/Masonry.h>
#import <XLsn0wKit_objc/XLsn0wKit_objc.h>

#define kIndicatorViewTag -1

@interface SubCell ()

@end

@implementation SubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _type = CellType_Default;
        [self customCell];
    }
    return self;
}

- (void)customCell {
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50*mas_width);
        make.height.mas_equalTo(15*mas_height);
        make.width.mas_equalTo(15*mas_width);
        make.top.mas_equalTo(18*mas_height);
    }];
    _iconImageView.image = [UIImage imageNamed:@"online"];
    
    @WeakObj(self);
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(18*mas_height);
    }];
    _name.font = [UIFont systemFontOfSize:18];
    _name.textColor = [UIColor xlsn0w_hexString:@"#454545"];
    _name.text = @"采集器";
    
    _sn = [[UILabel alloc] init];
    [self addSubview:_sn];
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.name);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(selfWeak.name.mas_bottom).offset(10);
    }];
    _sn.font = [UIFont systemFontOfSize:13];
    _sn.textColor = [UIColor xlsn0w_hexString:@"#959595"];
    _sn.text = @"1213r343";
    
    _arrow = [[UIImageView alloc] init];
    [self addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(12*mas_height);
        make.width.mas_equalTo(18*mas_width);
        make.centerY.mas_equalTo(self);
    }];
    _arrow.image = [UIImage imageNamed:@"arrow_right"];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor xlsn0w_hexString:@"#ECECEC"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.iconImageView.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(kScreenWidth-15);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
    }];
}


@end
