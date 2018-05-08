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
#import "XLsn0wLocation.h"

@interface XLsn0wLocation () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder        *geocoder;

@end

@implementation XLsn0wLocation

+ (instancetype)shared {
    static XLsn0wLocation *xlsn0wLocation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xlsn0wLocation = [[XLsn0wLocation alloc] init];
    });
    return xlsn0wLocation;
}

- (void)startLocationAddress:(GetLocationBlock)locationBlock {
    
    self.locationBlock = locationBlock;
    
    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
        return;
    }
    [self stopLocation];
    if (self.locationBlock) {
        self.locationBlock(nil);
    }
}

#pragma mark - <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    // 强制转换成简体中文
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil, nil] forKey:@"AppleLanguages"];
    
    __weak typeof (self) weakSelf = self;
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark=[placemarks firstObject];
        
        NSDictionary *locationInfo = [NSDictionary dictionary];
        
        [locationInfo setValue:placemark.addressDictionary forKey:@"addressDictionary"];
        [locationInfo setValue:placemark.name forKey:@"name"];
        [locationInfo setValue:placemark.country forKey:@"country"];
        [locationInfo setValue:placemark.postalCode forKey:@"postalCode"];
        [locationInfo setValue:placemark.ISOcountryCode forKey:@"ISOcountryCode"];
        [locationInfo setValue:placemark.administrativeArea forKey:@"administrativeArea"];
        [locationInfo setValue:placemark.subAdministrativeArea forKey:@"subAdministrativeArea"];
        [locationInfo setValue:placemark.locality forKey:@"locality"];
        [locationInfo setValue:placemark.subLocality forKey:@"subLocality"];
        [locationInfo setValue:placemark.thoroughfare forKey:@"thoroughfare"];
        [locationInfo setValue:placemark.subThoroughfare forKey:@"subThoroughfare"];

        if (weakSelf.locationBlock) {
            weakSelf.locationBlock (locationInfo);
        }
    }];
    // 停止定位
    [self stopLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self stopLocation];
    if (self.locationBlock) {
        self.locationBlock (nil);
    }
}

#pragma mark - lazy loading
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)stopLocation {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil; //这句话必须加上，否则可能会出现调用多次的情况
}

@end
