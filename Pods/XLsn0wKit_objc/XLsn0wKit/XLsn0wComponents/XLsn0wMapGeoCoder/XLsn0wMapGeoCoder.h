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
#import <Foundation/Foundation.h>

typedef void(^XLsn0wMapGeoInfoCallback)(NSMutableDictionary *mapGeoInfo);//存放获取到的信息的字典
typedef void(^GetAddressBlock)(NSString *address);

@interface XLsn0wMapGeoCoder : NSObject

///地理编码
//搜索输入的地址, 得到地址信息Dictionary(经纬度)
+ (void)searchAddress:(NSString *)address mapGeoInfoCallback:(XLsn0wMapGeoInfoCallback)mapGeoInfoCallback;

///逆向地理编码
//根据输入的经纬度<latitude(纬度),longitude(经度)>, 得到地址信息Dictionary(经纬度)
+ (void)inputLatitude:(NSString *)latitude
            longitude:(NSString *)longitude
   mapGeoInfoCallback:(XLsn0wMapGeoInfoCallback)mapGeoInfoCallback;

@end
