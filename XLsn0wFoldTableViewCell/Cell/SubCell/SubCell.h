
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellType) {
    CellType_Default,//默认从0开始
    CellType_WeatherStation,
};

@interface SubCell :UITableViewCell

@property (nonatomic, assign) CellType type;

@property (strong, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *sn;

@property (strong, nonatomic) UIImageView *arrow;


@end
