//
//  FromViewController.m
//  iOS7_New
//
//  Created by lincoln.liu on 2/14/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "FromViewController.h"
#import "ToViewController.h"

@interface FromViewController ()<ToViewControllerDelegate,UIViewControllerTransitioningDelegate>

@end


@implementation FromViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _presentAnimation = [[PresentAnimation alloc] init];
        _dismissAnimation = [[DismissAnimation alloc] init];
        _interactionAnimation = [[InteractAnimation alloc] init];
        _cubeAnimation = [[CubeAnimation alloc]init];
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

-(IBAction)changeViewController:(id)sender
{
    ToViewController *vc =[[ToViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    [self.interactionAnimation wireToViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
    [self addChildViewController:<#(UIViewController *)#>]
}

-(void) didClickedDismissButton:(ToViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.cubeAnimation;
}

-(id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactionAnimation.interacting? self.interactionAnimation:nil;
}
@end
