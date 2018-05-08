
#import <UIKit/UIKit.h>

@class DisplayImageCell;

@protocol DisplayImageCellDelegate <NSObject>

- (void)deleteDisplayImageCell:(DisplayImageCell *)displayImageCell;

@end

@interface XLsn0wDisplayImageCell : UICollectionViewCell

@property (nonatomic, weak) id<DisplayImageCellDelegate> xlDelegate;

@property (nonatomic ,retain) UIImageView *displayImageView;
@property (nonatomic, retain) UIImageView *minusPic;

- (void)displayCellWith :(NSString *)image;
- (void)setCellImage:(UIImage *)indexPathImage;

- (void)addMinusImage:(id)imagePath;
- (void)removeMinusImage:(UIImage *)indexPathImage;

@end

