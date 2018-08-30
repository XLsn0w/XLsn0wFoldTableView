
#import <UIKit/UIKit.h>

typedef void(^SuperCellBlock)(BOOL isShow, NSString* msg);

@interface SuperCell :UITableViewCell

@property (nonatomic, assign) SuperCellBlock superCellBlock;

/**
 * The boolean value showing the receiver is expandable or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;

/**
 * The boolean value showing the receiver is expanded or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *sn;
@property (strong, nonatomic) UIImageView *wifi;
@property (strong, nonatomic) UIImageView *gprs;

@property (strong, nonatomic) UIImageView *arrow;

/**
 * Adds an indicator view into the receiver when the relevant cell is expanded.
 */
- (void)addIndicatorView;

/**
 * Removes the indicator view from the receiver when the relevant cell is collapsed.
 */
- (void)removeIndicatorView;

/**
 * Returns a boolean value showing if the receiver contains an indicator view or not.
 *
 *  @return The boolean value for the indicator view.
 */
- (BOOL)containsIndicatorView;

- (void)accessoryViewAnimation;

@end
