//
//  MapViewController.m
//  UI高级测试
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 Ibokan. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = self.data[0];
    [self addLocationManager];
    map = [[MKMapView alloc]initWithFrame:[self.view bounds]];
    map.showsUserLocation = YES;
    map.mapType = MKMapTypeStandard;
    map.delegate =self;
    float latitude = [[self.data objectAtIndex:1]floatValue];
    float longitude = [[self.data objectAtIndex:2]floatValue];
    
    self.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
    map.region = MKCoordinateRegionMake(self.coordinate, MKCoordinateSpanMake(3.0, 3.0));
    MKPointAnnotation *daTouZhen = [[MKPointAnnotation alloc]init];
    [map addAnnotation:daTouZhen];
    [map selectAnnotation:daTouZhen animated:YES];
    daTouZhen.coordinate = self.coordinate;
    [self.view addSubview:map];
    
    
}
-(void)addLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {//判断手机是否可以定位
       CLLocationManager *locationManager = [[CLLocationManager alloc] init];//初始化位置管理器
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置精度
        locationManager.distanceFilter = 1000.0f;//设置距离筛选器
        [locationManager startUpdatingLocation];//启动位置管理器
    }else{
        NSLog(@"地图不好使");
    }
   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
