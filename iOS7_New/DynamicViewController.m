//
//  DynamicViewController.m
//  iOS7_New
//
//  Created by lincoln.liu on 1/23/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "DynamicViewController.h"
#import "NewtonsCradleView.h"
@interface DynamicViewController (){
    NewtonsCradleView *_cradleView;
}

@end

@implementation DynamicViewController

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
    _cradleView = [[NewtonsCradleView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_cradleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
