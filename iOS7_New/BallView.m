//
//  BallView.m
//  iOS7_New
//
//  Created by lincoln.liu on 1/22/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "BallView.h"

@implementation BallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3;
    }
    return self;
}
@end
