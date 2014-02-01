//
//  NewtonsCradleView.m
//  iOS7_New
//
//  Created by lincoln.liu on 1/22/14.
//  Copyright (c) 2014 xianlinbox. All rights reserved.
//

#import "NewtonsCradleView.h"

@implementation NewtonsCradleView{
    //球的个数
    NSUInteger ballCount;
    //球和锚点
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
        //初始化球和锚点
        [self createBallsAndAnchors];
        //添加UIDynamics动力行为
        [self applyDynamicBehaviors];
    }
    return self;
}

-(void)createBallsAndAnchors
{
    NSMutableArray *ballsArray  = [NSMutableArray array];
    NSMutableArray *anchorsArray  = [NSMutableArray array];
    //估算球的大小，占屏1/3，处于屏幕中间方便用户玩
    CGFloat ballSize = CGRectGetWidth(self.bounds)/(3.0*(ballCount-1));
    
    for(int i=0; i<ballCount; i++) {
        BallView *ball = [[BallView alloc] initWithFrame:CGRectMake(0, 0, ballSize-1, ballSize-1)];
        CGFloat x = CGRectGetWidth(self.bounds)/3.0+i*ballSize;
        CGFloat y = CGRectGetHeight(self.bounds)/1.5;
        ball.center = CGPointMake(x, y);
        //为球添加UIPushBehavior,支持用户拖动
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBallPan:)];
        [ball addGestureRecognizer:panGesture];
        //为球添加Oberser，当球的center属性发生改变时，会通知UIView的方法，刷新view，这儿主要是为了在球移动的时候保持锚点和球之间的连接线。
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
    //根据球的位置确定描点的位置
    anchor.y -= CGRectGetHeight(self.bounds) / 4.0;
    UIView *blueBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    blueBox.backgroundColor = [UIColor blueColor];
    blueBox.center = anchor;
    return blueBox;
}

//处理拖动手势
-(void)handleBallPan:(UIPanGestureRecognizer *)recoginizer
{
    //用户开始拖动时创建一个新的UIPushBehavior,并添加到animator中
    if(recoginizer.state == UIGestureRecognizerStateBegan){
        if (_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        _userDragBehavior = [[UIPushBehavior alloc] initWithItems:@[recoginizer.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:_userDragBehavior];
    }
    
    //用户完成拖动时，从animator移除PushBehavior
    _userDragBehavior.pushDirection = CGVectorMake([recoginizer translationInView:self].x/10.f, 0);
    if (recoginizer.state == UIGestureRecognizerStateEnded) {
        
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
}

#pragma mark - UIDynamics utility methods
- (void)applyDynamicBehaviors
{
    //添加UIDynamic的动力行为，同时把多个动力行为组合为一个复杂的动力行为。
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
    //为每个球到对应的锚点添加一个AttachmentBehavior，并作为一个子Behavior添加到一个Behavior中。
    for(int i=0; i<ballCount; i++)
    {
        UIDynamicBehavior *attachmentBehavior = [self createAttachmentBehaviorForBallBearing:[_balls objectAtIndex:i] toAnchor:[_anchors objectAtIndex:i]];
        [behavior addChildBehavior:attachmentBehavior];
    }
}

- (UIDynamicBehavior *)createAttachmentBehaviorForBallBearing:(id<UIDynamicItem>)ballBearing toAnchor:(id<UIDynamicItem>)anchor
{
    //把球attach到锚点上
    UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:ballBearing
                                                               attachedToAnchor:[anchor center]];
    
    return behavior;
}

- (UIDynamicBehavior *)createGravityBehaviorForObjects:(NSArray *)objects
{
//    为所有的球添加一个重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:objects];
    gravity.magnitude = 10;
    return gravity;
}

- (UIDynamicBehavior *)createCollisionBehaviorForObjects:(NSArray *)objects
{
    //    为所有的球添加一个碰撞行为
    return [[UICollisionBehavior alloc] initWithItems:objects];
}

- (UIDynamicItemBehavior *)createItemBehavior
{
    //    为所有的球的动力行为做一个公有配置，像空气阻力，摩擦力，弹性密度等
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:_balls];
    
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 1.f;
    return itemBehavior;
}

#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    Observer方法，当ball的center属性发生变化时，刷新整个view
    [self setNeedsDisplay];
}

//覆盖父类的方法，主要是为了在锚点和球之间画一条线
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

//添加了Observer必须释放，不然会造成内存泄露。
-(void)dealloc
{
    for (BallView *ball in _balls) {
        [ball removeObserver:self forKeyPath:@"center"];
    }
}

@end
