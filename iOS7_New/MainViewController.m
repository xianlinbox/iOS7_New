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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
