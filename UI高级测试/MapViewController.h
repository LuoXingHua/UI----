//
//  MapViewController.h
//  UI高级测试
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *map;

}
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)NSMutableArray *data;
@end
