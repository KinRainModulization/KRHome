//
//  KRCitiesHeaderView.h
//  KRHome
//
//  Created by LX on 2018/1/3.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LocationCityStatusDefault = 1, //定位中
    LocationCityStatusServing,     //定位成功且开通服务
    LocationCityStatusNotServing,  //定位成功 未开通服务
    LocationCityStatusFailure,     //定位失败
}LocationStatus;

@interface KRCitiesHeaderView : UIView

@property (nonatomic, copy) NSString *currentCity;

@property (nonatomic, copy) void (^locateCityBlock)(void);

- (void)locateCity:(NSString *)city withLocationStatus:(LocationStatus)status;

@end
