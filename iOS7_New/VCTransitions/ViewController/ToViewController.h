//
//  ToViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/14/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToViewController;
@protocol ToViewControllerDelegate <NSObject>

-(void) didClickedDismissButton:(ToViewController *)viewController;

@end

@interface ToViewController : UIViewController

@property (nonatomic, weak) id<ToViewControllerDelegate> delegate;

-(IBAction)back:(id)sender;

@end
