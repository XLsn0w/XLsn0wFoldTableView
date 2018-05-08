//
//  CALayer+XLsn0w.m
//  XLsn0w
//
//  Created by XLsn0w on 16/7/5.
//  Copyright © 2016年 XLsn0w. All rights reserved.
//

#import "CALayer+XLsn0w.h"

@implementation CALayer (XLsn0w)

@end

/**************************************************************************************************/

@implementation CALayer (JKBorderColor)

-(void)setJk_borderColor:(UIColor *)jk_borderColor{
    self.borderColor = jk_borderColor.CGColor;
}

- (UIColor*)jk_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end