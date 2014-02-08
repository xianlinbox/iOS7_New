//
//  BackgroundFetchViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/8/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundFetchViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

-(void) initImageViewWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
