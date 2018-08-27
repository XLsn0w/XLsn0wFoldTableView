//
//  WSTableView.h
//  WSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 
 *  WSTableView is a custom table view class extended from UITableView class. This class provides a single-level hierarchical
 *  structure for your contents. In order to minimalize the effectiveness of the table view, the default insertion and remove 
 *  mechanism of UITableView (insertRowsAtIndexPaths:withRowAnimation: and deleteRowsAtIndexPaths:withRowAnimation:) is used.
 *  Main rows of your table view, which can be expandable or not must be instances of WSTableViewCell class. Subrows can be
 *  instances of any class that is extended from UITableViewCell.
 */

@class FoldTableView;

#pragma mark - WSTableViewDelegate

@protocol FoldTableViewDelegate <UITableViewDataSource, UITableViewDelegate>

@required

/**
 * Returns the number of the subrows for the expandable row at the given index path.
 *
 *  @param tableView The instance of WSTableView class.
 *
 *  @param indexPath The index path of the expandable row. It is the value for the expandable row before expanding.
 *
 *  @return The number of the subrows.
 */
- (NSInteger)tableView:(FoldTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Returns the instance of UITableViewCell object for the cell at the given indexPath.
 *
 *  @param tableView The instance of WSTableView class.
 *
 *  @param indexPath The index path for the subrow. It has three properties that shows the exact position of the subrow cell.
 *                      These properties are named as section, row and subrow, all of which refers to the index of the object 
 *                      at the content array defined as data source of the table view.
 *
 *  @return The instance for the cell of subrow at the given indexPath.
 *
 *  @discussion In order to implement WSTableView class efficiently, your content for the data source of the table view should
 *                  be designed as:
 *                      
 *                                  contentArray[[(Section0)[row0,subrow1,subrow2,...],[row1,subrow1,subrow2,...],
 *                                  [row2, subrow1,subrow2,...],...],[(Section1)[...],[...],[...], ...],...]
 *
 *                  and indexPath for any subrow is formatted as below:
 *
 *                                  Section0-row1-subrow2 => NSIndexPath section = 0 / row = 1 / subrow = 2 (Third element of
 *                                                                                     the first element of the content array.)
 *
 *                 For further information, please check the sample table view[@ViewController] in the project.
 */
- (UITableViewCell *)tableView:(FoldTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/*
 * AWS the delegate for the height to use for a row at the given indexPath.
 *
 *  @param tableView The instance of WSTableView class.
 *
 *  @param indexPath The indexPath for the subrow. It has three properties that shows the exact position of the subrow cell.
 *                      These properties are named as section, row and subrow, all of which refers to the index of the object
 *                      at the content array defined as data source of the table view.
 *
 *  @return A nonnegative floating-point value that specifies the height (in points) that row should be.
 *
 *  @discussion The indexPath value refers to the exact location explained in the discussion section of tableView:cellForSubRowAtIndexPath:
 *                  delegate method. You should adjust height value accordingly. Default value is 44.0 points.
 */
- (CGFloat)tableView:(FoldTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Tells the delegate that the specified subrow is now selected.
 *
 *  @param tableView The instance of WSTableView class.
 *
 *  @param indexPath The indexPath for the subrow. It has three properties that shows the exact position of the 
 *   subrow cell. These properties are named as section, row and subrow, all of which refers to the index of the
 *   object at the content array defined as data source of the table view.
 */
- (void)tableView:(FoldTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * AWS the delegate whether the subrows of the cell at the given index path should be expanded initially.
 *
 *  @param tableView The instance of WSTableView class.
 *
 *  @param indexPath The index path of the row which subrows to be expanded while loading the data into the tableview.
 *
 *  @return The boolean value indicating the initial expandability of the row at the given index path.
 */
- (BOOL)tableView:(FoldTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(FoldTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(FoldTableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end

@interface FoldTableView : UITableView

/**
 * The FoldTableViewDelegate for the WSTableViewDelegate protocol.
 *
 *  @discussion You must set only this protocol for the delegation and the datasource of WSTableView instance.
 */
@property (nonatomic, weak) id<FoldTableViewDelegate> foldDelegate;

/**
 * A Boolean value indicating whether only one cell can be expanded at a time.
 *
 *  @discussion When set to YES, already-expanded cell is collapsed automatically before newly-selected cell is being expanded. 
 *      The default value for this property is NO.
 */
@property (nonatomic, assign) BOOL shouldExpandOnlyOneCell;

/**
 * Reload data for table view while collapsing already expanded index paths.
 *
 *  @discussion It is requested to scroll to a specific position after reload data, use refreshDataWithScrollingToIndexPath: method. This method does not change scroll 
 *      position.
 *////不可子类FoldTableView直接[self reloadData];
- (void)refreshData;///必须父类UITableView去刷新

/**
 * Relaod data and scroll to the given index path while collapsing already expanded index paths.
 *
 *  @param indexPath The index path which the table view should be scrolled to. DO NOT set subrow property.
 */
- (void)refreshDataWithScrollingToIndexPath:(NSIndexPath *)indexPath;

/**
 * Collapses all currently-expanded cells in the tableview altogether. No subrow is displayed, just main rows.
 */
- (void)collapseCurrentlyExpandedIndexPaths;

@end

#pragma mark - NSIndexPath (WSTableView)

@interface NSIndexPath (WSTableView)

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
