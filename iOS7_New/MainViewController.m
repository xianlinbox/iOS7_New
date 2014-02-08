//
//  MainViewController.m
//  iOS7_New
//
//  Created by lincoln.liu on 1/21/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.backgroundFetchViewController = [[BackgroundFetchViewController alloc] initWithNibName:@"BackgroundFetchViewController" bundle:nil];
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

-(IBAction)showUIDynamicDemo:(id)sender{
    DynamicViewController *dynamicViewController = [[DynamicViewController alloc] initWithNibName:@"DynamicDemoViewController" bundle:nil];
    [self.navigationController pushViewController:dynamicViewController animated:false];
}

-(IBAction)showNSURLSessionDemo:(id)sender
{
    UrlSessionDemoViewController  *urlViewController = [[UrlSessionDemoViewController alloc] initWithNibName:@"UrlSessionDemoViewController" bundle:nil];
    [self.navigationController pushViewController:urlViewController animated:false];
}

-(IBAction)showBackgroundFetchDemo:(id)sender
{
    NSLog(@"%@",self.backgroundFetchViewController.imageView.image);
    [self.navigationController pushViewController:self.backgroundFetchViewController animated:false];
}

-(void)fetchImageWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //调用子UIViewController的方法刷新UI
    NSLog(@"main controller called fetch");
    [self.backgroundFetchViewController initImageViewWithCompletionHandler:completionHandler];
}

@end
