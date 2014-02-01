//
//  UrlSessionDemoViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/1/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrlSessionDemoViewController : UIViewController<NSURLSessionDownloadDelegate>

@property (atomic,strong) IBOutlet UIImageView *imageView;

@property (atomic,strong) IBOutlet UIProgressView *progressBar;

@property (atomic,strong) IBOutlet UIButton *start;

@property (atomic,strong) IBOutlet UIButton *pause;

@property (atomic,strong) IBOutlet UIButton *resume;

@property (atomic, strong) NSURLSessionDownloadTask *task;
@property (atomic, strong) NSData *partialData;

-(IBAction)start:(id)sender;
-(IBAction)pause:(id)sender;
-(IBAction)resume:(id)sender;
@end
