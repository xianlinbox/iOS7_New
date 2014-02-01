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

@interface MainViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIButton *dynamicButton;
@property (nonatomic,weak) UIViewController *dynamicViewController;

-(IBAction)showUIDynamicDemo:(id)sender;
-(IBAction)showNSURLSessionDemo:(id)sender;

@end
