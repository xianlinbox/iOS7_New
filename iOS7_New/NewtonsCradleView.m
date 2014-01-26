//
//  NewtonsCradleView.m
//  iOS7_New
//
//  Created by lincoln.liu on 1/22/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "NewtonsCradleView.h"

@implementation NewtonsCradleView{
    NSUInteger ballCount;
    NSArray *_balls;
    NSArray *_anchors;
    UIDynamicAnimator *_animator;
    UIPushBehavior *_userDragBehavior;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ballCount = 5;
        [self createBallsAndAnchors];
        [self applyDynamicBehaviors];
    }
    return self;
}

-(void)createBallsAndAnchors
{
    NSMutableArray *ballsArray  = [NSMutableArray array];
    NSMutableArray *anchorsArray  = [NSMutableArray array];
    CGFloat ballSize = CGRectGetWidth(self.bounds)/(3.0*(ballCount-1));
    
    for(int i=0; i<ballCount; i++) {
        BallView *ball = [[BallView alloc] initWithFrame:CGRectMake(0, 0, ballSize-1, ballSize-1)];
        CGFloat x = CGRectGetWidth(self.bounds)/3.0+i*ballSize;
        CGFloat y = CGRectGetHeight(self.bounds)/1.5;
        
        ball.center = CGPointMake(x, y);
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBallPan:)];
        [ball addGestureRecognizer:panGesture];
        [ball addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:Nil];
        [ballsArray addObject:ball];
        [self addSubview:ball];
        
        UIView *blueBox = [self createAnchorForBall:ball];
        [anchorsArray addObject:blueBox];
        [self addSubview:blueBox];
    }
    
    _balls = ballsArray;
    _anchors = anchorsArray;
}

- (UIView *)createAnchorForBall:(BallView *)ball
{
    CGPoint anchor = ball.center;
    anchor.y -= CGRectGetHeight(self.bounds) / 4.0;
    UIView *blueBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    blueBox.backgroundColor = [UIColor blueColor];
    blueBox.center = anchor;
    return blueBox;
}

-(void)handleBallPan:(UIPanGestureRecognizer *)recoginizer
{
    if(recoginizer.state == UIGestureRecognizerStateBegan){
        if (_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        _userDragBehavior = [[UIPushBehavior alloc] initWithItems:@[recoginizer.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:_userDragBehavior];
    }
    
    _userDragBehavior.pushDirection = CGVectorMake([recoginizer translationInView:self].x/10.f, 0);
    if (recoginizer.state == UIGestureRecognizerStateEnded) {
        
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
}

#pragma mark - UIDynamics utility methods
- (void)applyDynamicBehaviors
{
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc] init];
    
    [self applyAttachBehaviorForBalls:behavior];
    [behavior addChildBehavior:[self createGravityBehaviorForObjects:_balls]];
    [behavior addChildBehavior:[self createCollisionBehaviorForObjects:_balls]];
    [behavior addChildBehavior:[self createItemBehavior]];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    [_animator addBehavior:behavior];
}

- (void)applyAttachBehaviorForBalls:(UIDynamicBehavior *)behavior
{
    for(int i=0; i<ballCount; i++)
    {
        UIDynamicBehavior *attachmentBehavior = [self createAttachmentBehaviorForBallBearing:[_balls objectAtIndex:i] toAnchor:[_anchors objectAtIndex:i]];
        [behavior addChildBehavior:attachmentBehavior];
    }
}

- (UIDynamicBehavior *)createAttachmentBehaviorForBallBearing:(id<UIDynamicItem>)ballBearing toAnchor:(id<UIDynamicItem>)anchor
{
    UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:ballBearing
                                                               attachedToAnchor:[anchor center]];
    
    return behavior;
}

- (UIDynamicBehavior *)createGravityBehaviorForObjects:(NSArray *)objects
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:objects];
    gravity.magnitude = 10;
    return gravity;
}

- (UIDynamicBehavior *)createCollisionBehaviorForObjects:(NSArray *)objects
{
    return [[UICollisionBehavior alloc] initWithItems:objects];
}

- (UIDynamicItemBehavior *)createItemBehavior
{
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:_balls];
    
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 2.f;
    return itemBehavior;
}

#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(id<UIDynamicItem> ballBearing in _balls){
        CGPoint anchor =[[_anchors objectAtIndex:[_balls indexOfObject:ballBearing]] center];
        CGPoint ballCenter = [ballBearing center];
        CGContextMoveToPoint(context, anchor.x, anchor.y);
        CGContextAddLineToPoint(context, ballCenter.x, ballCenter.y);
        CGContextSetLineWidth(context, 1.0f);
        [[UIColor blackColor] setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    [self setBackgroundColor:[UIColor whiteColor]];
}

-(void)dealloc
{
    for (BallView *ball in _balls) {
        [ball removeObserver:self forKeyPath:@"center"];
    }
}

@end
