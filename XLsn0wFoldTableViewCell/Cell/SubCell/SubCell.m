
#import "SubCell.h"
#import <Masonry/Masonry.h>
#import "Masonry.h"

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
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(18);
    }];
    _iconImageView.image = [UIImage imageNamed:@"alarm"];
    
//    @WeakObj(self);
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(18);
    }];
    _name.font = [UIFont systemFontOfSize:18];
    _name.textColor = [UIColor blueColor];
    _name.text = @"采集器";
    
    _sn = [[UILabel alloc] init];
    [self addSubview:_sn];
    [_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_name);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self->_name.mas_bottom).offset(10);
    }];
    _sn.font = [UIFont systemFontOfSize:13];
    _sn.textColor = [UIColor greenColor];
    _sn.text = @"88888343";
    
    _arrow = [[UIImageView alloc] init];
    [self addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(18);
        make.centerY.mas_equalTo(self);
    }];
    _arrow.image = [UIImage imageNamed:@"arrow_right"];
    
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


@end
