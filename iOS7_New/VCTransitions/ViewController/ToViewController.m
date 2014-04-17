//
//  ToViewController.m
//  iOS7_New
//
//  Created by lincoln.liu on 2/14/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "ToViewController.h"

@interface ToViewController ()

@end

@implementation ToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

-(IBAction)back:(id)sender
{
    if ([self delegate] && [self.delegate respondsToSelector:@selector(didClickedDismissButton:)]) {
        [self.delegate didClickedDismissButton:self];
    }
}

@end
