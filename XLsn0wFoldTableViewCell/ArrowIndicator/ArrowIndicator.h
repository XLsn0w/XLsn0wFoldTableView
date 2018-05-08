
#import <UIKit/UIKit.h>

/**
 *  WSTableViewCellIndicator is a custom class extended from UIView class. It is used to add a indicator view as subview for 
 *  the WSTableViewCell object when it is expanded.
 */

@interface ArrowIndicator : UIView

/**
 * Returns the color of the indicator view.
 *
 *  @discussion By default, this value equals to the seperator color of the table view, and if the seperator color is changed,
 *               the color of the indicator value is set automatically, too.
 */
+ (UIColor *)indicatorColor;

/**
 * Sets the color of the indicator view.
 *
 *  @param indicatorColor The color of the indicator view.
 */
+ (void)setIndicatorColor:(UIColor *)indicatorColor;

@end
