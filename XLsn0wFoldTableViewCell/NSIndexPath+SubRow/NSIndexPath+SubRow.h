//
//  NSIndexPath+SubRow.h
//  XLsn0wFoldTableView
//
//  Created by XLsn0w on 2019/2/3.
//  Copyright © 2019 ginlong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (SubRow)

/**
 * Subrow number of the indexPath for any cell object.
 */
@property (nonatomic, assign) NSInteger subRow;

/**
 * Initializes the newly-allocated NSIndexPath object with the given parameters.
 *
 *  @param subrow Subrow of the NSIndexPath object.
 *
 *  @param row Row of the NSIndexPath object.
 *
 *  @param section Section of the NSIndexPath object.
 *
 *  @return An initialized NSIndexPath object.
 */
+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
