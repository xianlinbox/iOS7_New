//
//  AVspeechViewController.h
//  iOS7_New
//
//  Created by lincoln.liu on 2/12/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVspeechViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UITextView *textToSpeak;

-(IBAction)playAudio:(id)sender;
@end
