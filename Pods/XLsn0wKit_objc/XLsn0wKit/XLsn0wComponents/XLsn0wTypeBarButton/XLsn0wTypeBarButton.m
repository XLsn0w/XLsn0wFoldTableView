//
//  TypeBarView.m
//  GinlongCloud
//
//  Created by ginlong on 2018/5/4.
//  Copyright © 2018年 ginlong. All rights reserved.
//

#import "XLsn0wTypeBarButton.h"
#import "Masonry.h"

@implementation XLsn0wTypeBarButton

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _number = [[UILabel alloc] init];
    [self addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(5);
    }];
    _number.font = [UIFont systemFontOfSize:11];
    
    
    _type = [[UILabel alloc] init];
    [self addSubview:_type];
    [_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-3);
    }];
    _type.font = [UIFont systemFontOfSize:16];
}

@end
