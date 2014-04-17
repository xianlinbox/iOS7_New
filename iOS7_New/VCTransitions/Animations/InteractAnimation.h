//
//  InteractAnimation.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/16/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;

- (void)wireToViewController:(UIViewController*)viewController;

@end
