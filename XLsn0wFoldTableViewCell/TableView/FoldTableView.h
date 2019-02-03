
#import <UIKit/UIKit.h>

@class FoldTableView;

/// 本折叠Cell采取两种自定义Cell
/// HeaderInSection并不用到

@protocol FoldTableViewDelegate <UITableViewDataSource, UITableViewDelegate>

@required
- (NSInteger)tableView:(FoldTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(FoldTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath;///NSIndexPath可以获取SubRow

@optional
- (CGFloat)tableView:(FoldTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(FoldTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(FoldTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath;

///截获外部Header代理
- (CGFloat)tableView:(FoldTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(FoldTableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (UIView *)tableView:(FoldTableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(FoldTableView *)tableView heightForFooterInSection:(NSInteger)section;

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
