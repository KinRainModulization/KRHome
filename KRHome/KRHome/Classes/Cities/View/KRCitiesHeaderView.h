//
//  KRCitiesHeaderView.h
//  KRHome
//
//  Created by LX on 2018/1/3.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LocationCityStatusServing = 1, //定位成功且开通服务
    LocationCityStatusNotServing,  //定位成功 未开通服务
    LocationCityStatusFailure,     //定位失败
}LocationStatus;

@interface KRCitiesHeaderView : UIView

@end
