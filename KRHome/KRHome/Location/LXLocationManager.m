//
//  LXLocation.m
//  KRHome
//
//  Created by LX on 2018/1/2.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "LXLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LXLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) void (^locationBlock)(NSDictionary *location);

@end

@implementation LXLocationManager

- (void)requestLocationWithCompletionBlock:(void (^)(NSDictionary *location))completionBlock {
    [self beginUpdatingLocation];
    self.locationBlock = completionBlock;
}

- (void)beginUpdatingLocation {
    MLog(@"beginUpdatingLocation");
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation * newLocation = locations.lastObject;

    CLGeocoder * geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        if (placemarks.count > 0) {

            CLPlacemark * placemark = placemarks.firstObject;
            MLog(@"placemark=%@",placemark);
//            self.locationBlock(@{
//                                 @"latitude": @(newLocation.coordinate.latitude),
//                                 @"longitude": @(newLocation.coordinate.longitude),
//                                 @"country": placemark.country,
//                                 @"province": placemark.administrativeArea,
//                                 @"city": placemark.locality,
//                                 @"district": placemark.subLocality,
//                                 @"street":placemark.thoroughfare,
////                                 @"citycode":
//                                 });
            NSDictionary *dict = @{
                                   @"latitude": @(newLocation.coordinate.latitude),
                                   @"longitude": @(newLocation.coordinate.longitude),
                                   @"country": placemark.country,
                                   @"province": placemark.administrativeArea,
                                   @"city": placemark.locality,
                                   @"district": placemark.subLocality,
                                   @"street":placemark.thoroughfare,
                                   };
            //存储位置信息
//            location.country = placemark.country;
//            location.administrativeArea = placemark.administrativeArea;
//            location.locality = placemark.locality;
//            location.subLocality = placemark.subLocality;
//            location.thoroughfare = placemark.thoroughfare;
//            location.subThoroughfare = placemark.subThoroughfare;
        }
    }];
    [manager stopUpdatingLocation];
}

- (CLLocationManager *)locationManager {
    
    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;
        
        // 设置定位精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是 requestAlwaysAuthorization
        // 一个是 requestWhenInUseAuthorization
        [_locationManager requestAlwaysAuthorization];//ios8以上版本使用。
    }
    return _locationManager;
}

@end
