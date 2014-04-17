//
//  FromViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/14/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentAnimation.h"
#import "DismissAnimation.h"
#import "InteractAnimation.h"
#import "CubeAnimation.h"

@interface FromViewController : UIViewController

@property (nonatomic, strong) PresentAnimation *presentAnimation;
@property (nonatomic, strong) DismissAnimation *dismissAnimation;
@property (nonatomic, strong) InteractAnimation *interactionAnimation;
@property (nonatomic, strong) CubeAnimation *cubeAnimation;

-(IBAction)changeViewController:(id)sender;
@end
