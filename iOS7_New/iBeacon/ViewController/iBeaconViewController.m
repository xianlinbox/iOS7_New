//
//  iBeaconViewController.m
//  iOS7_New
//
//  Created by Xianning Liu on 3/5/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "iBeaconViewController.h"

@interface iBeaconViewController ()

@end

@implementation iBeaconViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _manager =[[CLLocationManager alloc] init];
        _manager.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)startBeacon:(id)sender
{
    _uuid = [[NSUUID alloc] initWithUUIDString:@"48F8820C-118E-4ADD-AB78-69B115D948B1"];
    _region = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid identifier:@"xianlinbox's beacon"];
    [_manager startMonitoringForRegion:_region];
}

-(IBAction)searchBeacons:(id)sender
{
    _uuid = [[NSUUID alloc] initWithUUIDString:@"74278BDA-B644-4520-8F0C-720EAF059935"];
    _region = [[CLBeaconRegion alloc]initWithProximityUUID:_uuid identifier:@"xianlinbox's beacon"];
    [_manager startRangingBeaconsInRegion:_region];
}

#pragma CLLocationManager delegate
- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    NSLog(@"Enter region");
    [_manager startRangingBeaconsInRegion:_region];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    NSLog(@"Exit region");
    [self.manager stopRangingBeaconsInRegion:self.region];
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Starting monitor: %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"Beacons in the range");
    
    if ([region isEqual:_region]) {
        CLBeacon *beacon = [beacons firstObject];
        _textView.text = [NSString stringWithFormat:@"%@, major:%@, minor:%@ : %f",[beacon proximityUUID],[beacon major],[beacon minor],[beacon accuracy]];
    }
}

@end
