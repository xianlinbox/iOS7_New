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

@interface MainViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *dynamicButton;
@property (nonatomic,weak) UIViewController *dynamicViewController;
@property (nonatomic,strong) BackgroundFetchViewController *backgroundFetchViewController;

-(IBAction)showUIDynamicDemo:(id)sender;
-(IBAction)showNSURLSessionDemo:(id)sender;
-(IBAction)showBackgroundFetchDemo:(id)sender;

-(void)fetchImageWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
