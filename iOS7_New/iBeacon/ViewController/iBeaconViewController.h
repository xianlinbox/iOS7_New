//
//  iBeaconViewController.h
//  iOS7_New
//
//  Created by Xianning Liu on 3/5/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreBluetooth;
@import CoreLocation;

@interface iBeaconViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic,strong) NSUUID *uuid;
@property (nonatomic,strong) CLBeaconRegion *region;
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) IBOutlet UITextView  *textView;


-(IBAction)startBeacon:(id)sender;
-(IBAction)searchBeacons:(id)sender;
@end
