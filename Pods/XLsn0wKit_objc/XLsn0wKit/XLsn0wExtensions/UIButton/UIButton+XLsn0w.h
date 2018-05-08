
#import <UIKit/UIKit.h>

@interface UIButton (XLsn0w)

@end

@interface UIButton (BadgeView)

/**
 *  Remove the badge value on the button.
 */
- (void)xlsn0w_removeBadgeValue;

/**
 *  Add a badge value view on the button.
 *
 *  @param strBadgeValue The badge value.
 *
 *  @return A view contrain the badge value.
 */
- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue;

/**
 *  Add a badage value view use the padding position.
 *
 *  @param strBadgeValue The badge value.
 *  @param point         The padding offset position.
 *
 *  @return A view contrain the badge value.
 */
- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue andPadding:(CGPoint)point;

@end


@interface UIButton (XLButtonCenterStyle)

/**
 *  Set the title & image center in the button bounds
 *
 *  @param space The title & image space
 */
- (void)xlsn0w_centerImageAndTitle:(float)space;

/**
 *  Default center method.
 */
- (void)xlsn0w_centerImageAndTitle;

@end

@interface StretchButton : UIButton

@end








