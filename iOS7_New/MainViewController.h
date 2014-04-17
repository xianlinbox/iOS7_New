//
//  MainViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 1/21/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicViewController.h"
#import "UrlSessionDemoViewController.h"
#import "BackgroundFetchViewController.h"
#import "AVspeechViewController.h"
#import "FromViewController.h"
#import "iBeaconViewController.h"

@interface MainViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *dynamicButton;
@property (nonatomic,weak) UIViewController *dynamicViewController;
@property (nonatomic,strong) BackgroundFetchViewController *backgroundFetchViewController;

-(IBAction)showUIDynamicDemo:(id)sender;
-(IBAction)showNSURLSessionDemo:(id)sender;
-(IBAction)showBackgroundFetchDemo:(id)sender;
-(IBAction)showAVSpeechDemo:(id)sender;
-(IBAction)showVCTransitions:(id)sender;
-(IBAction)showiBeacondemo:(id)sender;

-(void)fetchImageWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
