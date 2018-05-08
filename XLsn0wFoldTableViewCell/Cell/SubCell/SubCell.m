
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
        make.left.mas_equalTo(15*mas_width);
        make.height.mas_equalTo(50*mas_height);
        make.width.mas_equalTo(50*mas_width);
        make.centerY.mas_equalTo(self);
    }];
    _iconImageView.image = [UIImage imageNamed:@"alarm"];
    
    @WeakObj(self);
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(18*mas_height);
    }];
    _name.font = [UIFont systemFontOfSize:15];
    _name.textColor = [UIColor blackColor];
    _name.text = @"采集器";
    
    _sn = [[UILabel alloc] init];
    [self addSubview:_sn];
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.name.mas_right).offset(10);
        make.height.mas_equalTo(10*mas_height);
        make.top.mas_equalTo(selfWeak.name);
    }];
    _sn.font = [UIFont systemFontOfSize:10];
    _sn.textColor = [UIColor blackColor];
    _sn.text = @"1213r343";
    
    _nowPower = [[UILabel alloc] init];
    [self addSubview:_nowPower];
    [_nowPower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.name.mas_bottom).offset(10);
    }];
    _nowPower.font = [UIFont systemFontOfSize:12];
    _nowPower.text = @"10KW";
    _nowPower.textColor = [UIColor orangeColor];
    
    _todayPower = [[UILabel alloc] init];
    [self addSubview:_todayPower];
    [_todayPower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.nowPower.mas_right).offset(50);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.name.mas_bottom).offset(10);
    }];
    _todayPower.font = [UIFont systemFontOfSize:12];
    _todayPower.text = @"10KW";
    _todayPower.textColor = [UIColor orangeColor];
    
    _allPower = [[UILabel alloc] init];
    [self addSubview:_allPower];
    [_allPower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.todayPower.mas_right).offset(50);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.name.mas_bottom).offset(10);
    }];
    _allPower.font = [UIFont systemFontOfSize:12];
    _allPower.text = @"10KW";
    _allPower.textColor = [UIColor orangeColor];
    
    _nowPowerStr = [[UILabel alloc] init];
    [self addSubview:_nowPowerStr];
    [_nowPowerStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.nowPower.mas_bottom).offset(10);
    }];
    _nowPowerStr.font = [UIFont systemFontOfSize:12];
    _nowPowerStr.text = @"当前功率";
    _nowPower.textColor = [UIColor xlsn0w_hexString:@"#525252"];
    
    _todayPowerStr = [[UILabel alloc] init];
    [self addSubview:_todayPowerStr];
    [_todayPowerStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.nowPower.mas_right).offset(50);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.todayPower.mas_bottom).offset(10);
    }];
    _todayPowerStr.font = [UIFont systemFontOfSize:12];
    _todayPowerStr.text = @"日发电量";
    _todayPowerStr.textColor = [UIColor xlsn0w_hexString:@"#525252"];
    
    _allPowerStr = [[UILabel alloc] init];
    [self addSubview:_allPowerStr];
    [_allPowerStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfWeak.todayPower.mas_right).offset(50);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(selfWeak.allPower.mas_bottom).offset(10);
    }];
    _allPowerStr.font = [UIFont systemFontOfSize:12];
    _allPowerStr.text = @"累计电量";
    _allPowerStr.textColor = [UIColor xlsn0w_hexString:@"#525252"];
    
    _time = [[UILabel alloc] init];
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(10*mas_height);
        make.bottom.mas_equalTo(-5*mas_height);
    }];
    _time.font = [UIFont systemFontOfSize:10];
    _time.textColor = [UIColor blackColor];
    _time.text = @"更新于10秒";
    
    _arrow = [[UIImageView alloc] init];
    [self addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(12*mas_height);
        make.width.mas_equalTo(18*mas_width);
        make.centerY.mas_equalTo(self);
    }];
    _arrow.image = [UIImage imageNamed:@"expandableImage@2x"];
    
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
