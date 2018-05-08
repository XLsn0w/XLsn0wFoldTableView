#import <UIKit/UIKit.h>

@interface UILabel (MultipleLines)

/**
 *  文本是一行就能显示
 */
@property (nonatomic,assign,setter=setSingleLine:)BOOL isSingleLine;

@property (nonatomic,assign)CGSize lbTextSize;  //属性不可以是textSize


/**
 *  设置文本多行可控间距显示
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数,文本显示不足lines，正常显示。超过lines,结尾部分的内容以……方式省略
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */


- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;


/**
 *  计算文本占用的size
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数
 *  @param font        字体类型
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */
+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;


@end
