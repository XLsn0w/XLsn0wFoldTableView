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

typedef void(^JFSearchViewChoseCityReultBlock)(NSDictionary *cityData);
typedef void(^JFSearchViewBlock)(void);

@interface XLsn0wCitySearchView : UIView

/** 搜索结果*/
@property (nonatomic, strong) NSMutableArray *resultMutableArray;

@property (nonatomic, copy) JFSearchViewChoseCityReultBlock resultBlock;
@property (nonatomic, copy) JFSearchViewBlock touchViewBlock;


/**
 点击搜索结果回调函数

 @param block 回调
 */
- (void)resultBlock:(JFSearchViewChoseCityReultBlock)block;


/**
 点击空白View回调，取消搜索

 @param block 回调
 */
- (void)touchViewBlock:(JFSearchViewBlock)block;


@end
