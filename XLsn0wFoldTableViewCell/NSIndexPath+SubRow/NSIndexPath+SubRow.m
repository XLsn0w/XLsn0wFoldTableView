//
//  NSIndexPath+SubRow.m
//  XLsn0wFoldTableView
//
//  Created by XLsn0w on 2019/2/3.
//  Copyright © 2019 ginlong. All rights reserved.
//

#import "NSIndexPath+SubRow.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark - NSIndexPath (通过runtime添加属性subRow)

@implementation NSIndexPath (SubRow)

static void *SubRowObjectKey;
- (NSInteger)subRow {
    id subRowObj = objc_getAssociatedObject(self, SubRowObjectKey);
    return [subRowObj integerValue];///把对象转NSInteger
}

- (void)setSubRow:(NSInteger)subRow {
    id subRowObj = [NSNumber numberWithInteger:subRow];
    objc_setAssociatedObject(self, SubRowObjectKey, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    indexPath.subRow = subrow;
    return indexPath;
}

@end
