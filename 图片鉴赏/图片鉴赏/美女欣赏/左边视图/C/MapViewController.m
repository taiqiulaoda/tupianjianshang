//
//  MapViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/30.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    
    [self _location];
    
    [self creatMapView];
}

-(void)creatView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    view.backgroundColor = [UIColor colorWithRed:180/255.0 green:53/255.0 blue:55/255.0 alpha:1];
    [self.view addSubview:view];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 50, 20)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
}



-(void)backAction:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)_location{
    if (_locationManager == nil) {
    // NSLog(@"我是空的");
        _locationManager = [[CLLocationManager alloc]init];
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"定位");
    
    //停止定位
    [manager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度 %lf ,纬度 %lf",coordinate.longitude,coordinate.latitude);
    
    
    //反编码
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);
    }];


}

//创建地图视图
-(void)creatMapView{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    //显示用户所在
    _mapView.showsUserLocation = YES;
    
    _mapView.mapType = MKMapTypeStandard;
    
    _mapView.delegate = self;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:_mapView];

}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocation *location = [userLocation location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSLog(@"纬度 %lf,经度 %lf",coordinate.latitude,coordinate.longitude);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
