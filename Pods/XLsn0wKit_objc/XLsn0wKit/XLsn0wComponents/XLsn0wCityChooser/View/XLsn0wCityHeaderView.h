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

typedef void(^JFCityHeaderViewBlock)(BOOL selected);
typedef void(^JFCityHeaderViewSearchBlock)(void);
typedef void(^JFCityHeaderViewSearchResultBlock)(NSString *result);

@interface XLsn0wCityHeaderView : UIView

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSString *buttonTitle;

@property (nonatomic, copy) JFCityHeaderViewBlock cityNameBlock;


@property (nonatomic, copy) JFCityHeaderViewSearchBlock beginSearchBlock;

@property (nonatomic, copy) JFCityHeaderViewSearchBlock didSearchBlock;

@property (nonatomic, copy) JFCityHeaderViewSearchResultBlock searchResultBlock;

/// 取消搜索
- (void)cancelSearch;

- (void)cityNameBlock:(JFCityHeaderViewBlock)block;

/**
 点击搜索框的回调函数
 */
- (void)beginSearchBlock:(JFCityHeaderViewSearchBlock)block;

/**
 结束搜索的回调函数
 */
- (void)didSearchBlock:(JFCityHeaderViewSearchBlock)block;

/**
 搜索结果回调函数
 */
- (void)searchResultBlock:(JFCityHeaderViewSearchResultBlock)block;

@end
