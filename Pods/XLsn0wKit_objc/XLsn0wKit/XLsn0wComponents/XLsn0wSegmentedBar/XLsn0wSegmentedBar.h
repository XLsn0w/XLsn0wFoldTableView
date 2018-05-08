/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <UIKit/UIKit.h>

@class XLsn0wSegmentedView;
@class XLsn0wSegmentedBar;

@protocol XLsn0wSegmentedBarDelegate <NSObject>

- (void)segmentedBar:(XLsn0wSegmentedBar *)segmentedBar didSelectAtIndex:(NSInteger)index;

@end

@interface XLsn0wSegmentedBar : UIView

@property (nonatomic, weak) id<XLsn0wSegmentedBarDelegate> xlsn0wDelegate;

@property (strong, nonatomic) XLsn0wSegmentedView *xlsn0wSegmentedView;
@property (strong, nonatomic) UIScrollView *bottomScrollView;

/*! 初始化前必须添加此行代码 self.automaticallyAdjustsScrollViewInsets = NO;//自动滚动调整，默认为YES */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray subviewArray:(NSArray *)subviewArray;
    
@end

/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <QuartzCore/QuartzCore.h>

typedef void(^btnClickBlock)(NSInteger index);

@interface XLsn0wSegmentedView : UIView

/**
 *  是否开启下划线动画 默认开启
 */
@property (nonatomic, assign) BOOL isLoadAnimation;

/**
 *  未选中时的文字颜色,默认黑色
 */
@property (nonatomic,strong) UIColor *titleNomalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  *titleFont;

/**
 *  默认选中的index=1，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;

/**
 *  点击后的block
 */
@property (nonatomic,copy)btnClickBlock block;

/**
 *  初始化方法
 *
 *  @param frame      frame
 *  @param titleArray 传入数组
 *  @param block      点击后的回调
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block;

-(void)updateselectLineFrameWithoffset:(CGFloat)offsetx;

@end

/**************************************************************************************************/

@interface CALayer (XLsn0wSegmentedBar)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///< Shortcut for frame.size.

/**
 *  旋转
 */
@property (nonatomic) CGFloat transformRotation;     ///< key path "transform.rotation"
@property (nonatomic) CGFloat transformRotationX;    ///< key path "transform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    ///< key path "transform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    ///< key path "transform.rotation.z"

/**
 *  缩放
 */
@property (nonatomic) CGFloat transformScale;        ///< key path "transform.scale"
@property (nonatomic) CGFloat transformScaleX;       ///< key path "transform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       ///< key path "transform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       ///< key path "transform.scale.z"

/**
 *  平移
 */
@property (nonatomic) CGFloat transformTranslationX; ///< key path "transform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; ///< key path "transform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; ///< key path "transform.translation.z"

@end

/**************************************************************************************************/

@interface NSString (XLsn0wSegmentedBar)
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

@end


