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
#import "XLsn0wMapGeoCoder.h"
#import "XLsn0wKit_objc.h"

@implementation XLsn0wMapGeoCoder

/*
 location  ------------ 位置  --  (CLLocation)
 region    ------------ 地区  --  (CLRegion)
 timeZone  ------------ 时区  --  (NStimeZone)
 addressDictionary ---- 地址字典 - (NSDictionary)
 name      -------------名字  --  (NSString)
 thoroughfare --------- 街道  --  (NSString)
 subThoroughfare ------ 子街道 -- (NSString)
 locality  ------------ 位置  --  (NSString)
 subLocality ---------- 子位置 --  (NSString)
 administrativeArea---- 行政区域 -- (NSString)
 subAdministrativeArea--子行政区域- (NSString)
 postalCode ----------- 邮政代码 -- (NSString)
 ISOcountryCode ------- ISO国家代码-(NSString)
 country ---------------国家  --   (NSString)
 inlandWater ---------- 内陆水--   (NSString)
 ocean     ------------ 海洋  --   (NSString)
 areasOfInterest ------ 感兴趣的地方-(NSArray)
 */
//这个方法可以取到<输入地点>的所有信息
+ (void)searchAddress:(NSString *)address mapGeoInfoCallback:(XLsn0wMapGeoInfoCallback)mapGeoInfoCallback {
    //[self grayView];
    NSMutableDictionary *mapGeoInfo = [[NSMutableDictionary alloc] init];
    
    CLGeocoder *mapGeocoder = [[CLGeocoder alloc] init];
    [mapGeocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            //菊花消失,加载没有查到地址的提示,设置时间让它消失
            XLsn0wLog(@"没有查询到此地址");
        }else{
            CLPlacemark *place = [placemarks firstObject];
            CLLocationDegrees Weidu = place.location.coordinate.latitude;
            CLLocationDegrees Jindu = place.location.coordinate.longitude;
            NSString *lat = [NSString stringWithFormat:@"%.2f",Weidu];
            NSString *lon = [NSString stringWithFormat:@"%.2f",Jindu];
            CLRegion *clregion = [[CLRegion alloc]init];
            clregion = place.region;
            NSString *clr = [NSString stringWithFormat:@"%@",clregion];
            NSTimeZone *timeZone = [[NSTimeZone alloc]init];
            timeZone = place.timeZone;
            NSString *timeZon = [NSString stringWithFormat:@"%@",timeZone];
            [mapGeoInfo setValue:lat forKey:@"latitude"];//纬度
            [mapGeoInfo setValue:lon forKey:@"longitude"];//经度
            [mapGeoInfo setValue:clr forKey:@"region"];//地区
            [mapGeoInfo setValue:timeZon forKey:@"timeZone"];//时区
            [mapGeoInfo setValue:place.name forKey:@"name"];
            [mapGeoInfo setValue:place.thoroughfare forKey:@"thoroughfare"];
            [mapGeoInfo setValue:place.subThoroughfare forKey:@"subThoroughfare"];
            [mapGeoInfo setValue:place.locality forKey:@"locality"];
            [mapGeoInfo setValue:place.subLocality forKey:@"subLocality"];
            [mapGeoInfo setValue:place.administrativeArea forKey:@"administrativeArea"];
            [mapGeoInfo setValue:place.subAdministrativeArea forKey:@"subAdministrativeArea"];
            [mapGeoInfo setValue:place.postalCode forKey:@"postalCode"];
            [mapGeoInfo setValue:place.ISOcountryCode forKey:@"ISOcountryCode"];
            [mapGeoInfo setValue:place.country forKey:@"country"];
            [mapGeoInfo setValue:place.inlandWater forKey:@"inlandWater"];
            [mapGeoInfo setValue:place.ocean forKey:@"ocean"];
            [mapGeoInfo setValue:place.areasOfInterest forKey:@"areasOfInterest"];
            [mapGeoInfo setValue:place.addressDictionary forKey:@"addressDictionary"];
            
            mapGeoInfoCallback(mapGeoInfo);
            
            XLsn0wLog(@"%@", mapGeoInfo);
        }
    }];
}

//这个方法可以取到<输入经纬度>的所有信息
+ (void)inputLatitude:(NSString *)latitude longitude:(NSString *)longitude mapGeoInfoCallback:(XLsn0wMapGeoInfoCallback)mapGeoInfoCallback {

    CLGeocoder *mapGeocoder = [[CLGeocoder alloc] init];
    NSMutableDictionary *mapGeoInfo = [[NSMutableDictionary alloc] init];
    
    if (latitude.length<1 || longitude.length <1) {
        XLsn0wLog(@"没有查询到此经纬度");
    }else{
        CLLocationDegrees weiduude = [latitude doubleValue];
        CLLocationDegrees jinduude = [longitude doubleValue];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:weiduude longitude:jinduude];
        [mapGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error || placemarks.count == 0) {
                //菊花消失,加载没有查到地址的提示,设置时间让它消失
                XLsn0wLog(@"没有查询到此经纬度");
            }else{
                CLPlacemark *place = [placemarks firstObject];
                CLLocationDegrees Weidu = place.location.coordinate.latitude;
                CLLocationDegrees Jindu = place.location.coordinate.longitude;
                NSString *lat = [NSString stringWithFormat:@"%.2f",Weidu];
                NSString *lon = [NSString stringWithFormat:@"%.2f",Jindu];
                CLRegion *clregion = [[CLRegion alloc]init];
                clregion = place.region;
                NSString *clr = [NSString stringWithFormat:@"%@",clregion];
                NSTimeZone *timeZone = [[NSTimeZone alloc]init];
                timeZone = place.timeZone;
                NSString *timeZon = [NSString stringWithFormat:@"%@",timeZone];
                
                [mapGeoInfo setValue:lat forKey:@"latitude"];//纬度
                [mapGeoInfo setValue:lon forKey:@"longitude"];//经度
                [mapGeoInfo setValue:clr forKey:@"region"];//地区
                [mapGeoInfo setValue:timeZon forKey:@"timeZone"];//时区
                [mapGeoInfo setValue:place.name forKey:@"name"];
                [mapGeoInfo setValue:place.thoroughfare forKey:@"thoroughfare"];
                [mapGeoInfo setValue:place.subThoroughfare forKey:@"subThoroughfare"];
                [mapGeoInfo setValue:place.locality forKey:@"locality"];
                [mapGeoInfo setValue:place.subLocality forKey:@"subLocality"];
                [mapGeoInfo setValue:place.administrativeArea forKey:@"administrativeArea"];
                [mapGeoInfo setValue:place.subAdministrativeArea forKey:@"subAdministrativeArea"];
                [mapGeoInfo setValue:place.postalCode forKey:@"postalCode"];
                [mapGeoInfo setValue:place.ISOcountryCode forKey:@"ISOcountryCode"];
                [mapGeoInfo setValue:place.country forKey:@"country"];
                [mapGeoInfo setValue:place.inlandWater forKey:@"inlandWater"];
                [mapGeoInfo setValue:place.ocean forKey:@"ocean"];
                [mapGeoInfo setValue:place.areasOfInterest forKey:@"areasOfInterest"];
                [mapGeoInfo setValue:place.addressDictionary forKey:@"addressDictionary"];
                
                mapGeoInfoCallback(mapGeoInfo);
                
                XLsn0wLog(@"%@", mapGeoInfo);
            }
        }];
    }
}

@end
