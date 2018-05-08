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

typedef void(^XLsn0wCityChooserBlock)(NSString *cityName);

@interface XLsn0wCityChooser : UIViewController

@property (nonatomic, copy) XLsn0wCityChooserBlock choseCityBlock;

/**
 选择城市后的回调
 */
- (void)choseCityBlock:(XLsn0wCityChooserBlock)block;

@end

/*

 获取定位权限：
 
 Privacy - Location Always Usage Description        类型为String
 Privacy - Location When In Use Usage Description   类型为String
 
 本地化（搜索按钮的英文变成中文）：
 
 将Localization native development region   value值改成China
 
*/
