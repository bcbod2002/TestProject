//
//  AppNotificationMessage.m
//  TestProject
//
//  Created by shinsoft on 2014/6/26.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "AppNotificationMessage.h"

@implementation AppNotificationMessage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithMessageTitle:(NSString *)title
{
    
    if (self)
    {
        self = [super initWithFrame:CGRectMake(20, 20 + 30, 25, 25)];
//        [self.layer setCornerRadius:12.5];
        [self setBackgroundColor:[UIColor redColor]];
//        [self circleMaskwithOtherMask];
    }
    return self;
}

-(void)circleAppear
{
//    [self.layer addSublayer:[self createPieSlice]];
    
    //Spin and flip
    CAKeyframeAnimation *anchorZSpin = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transformZSpinForword = CATransform3DIdentity;
    CATransform3D transformZSpinBackword = CATransform3DIdentity;
    
    transformZSpinForword.m34 = -1.0f / 200.0f;
    transformZSpinForword = CATransform3DRotate(transformZSpinForword, M_PI, 0, 0, 1);
    transformZSpinBackword.m34 = -1.0f / 200.0f;
    transformZSpinBackword = CATransform3DRotate(transformZSpinBackword, -M_PI, 1, 0, 0);
    
    
    NSValue *nonePerspective = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
    NSValue *forwordPerspective = [NSValue valueWithCATransform3D:transformZSpinForword];
    NSValue *backwordPerspective = [NSValue valueWithCATransform3D:transformZSpinBackword];
    
    NSArray *spinPerspectiveMove = [NSArray arrayWithObjects:nonePerspective, forwordPerspective, backwordPerspective, nil];
    NSArray *spinPerspectiveTime = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:0.4], [NSNumber numberWithFloat:0.8], nil];
    
    [anchorZSpin setValues:spinPerspectiveMove];
    [anchorZSpin setKeyTimes:spinPerspectiveTime];
    [anchorZSpin setDuration:0.8];
    [anchorZSpin setRemovedOnCompletion:NO];
    [anchorZSpin setFillMode:kCAFillModeForwards];
    [anchorZSpin setDelegate:self];
    
//    [self.layer addAnimation:anchorZSpin forKey:@"spinZ"];
    
    // Triangle
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.fillColor = [UIColor blueColor].CGColor;

    
    triangleLayer.strokeColor = [UIColor blackColor].CGColor;
    triangleLayer.lineWidth = 2;
    
    UIBezierPath *squarePath = [UIBezierPath bezierPath];
    CGPoint firstSq = CGPointMake(25, 25);
    CGPoint secondSq = CGPointMake(25, 0);
    CGPoint thirdSq = CGPointMake(0, 0);
    CGPoint forthSq = CGPointMake(0, 25);
    
    [squarePath moveToPoint:forthSq];
    [squarePath addLineToPoint:firstSq];
    [squarePath addLineToPoint:secondSq];
    [squarePath addLineToPoint:thirdSq];
    [squarePath addLineToPoint:forthSq];
    [squarePath closePath];
//    CGPathRef moveSq = squarePath.
    
    // Bezier
    UIBezierPath *circleBezPath = [UIBezierPath bezierPath];
    
    CGPoint center =  CGPointMake(12.5, 12.5);
    CGPoint first = CGPointMake(12.5, 0);
    CGPoint second = CGPointMake(12.5, 25);
    CGPoint third = CGPointMake(-12.5, 12.5);
    
    [circleBezPath moveToPoint:first];
//    [circleBezPath addArcWithCenter:center radius:12.5 startAngle:-M_PI * 3 / 2 endAngle:-M_PI / 2 clockwise:NO];
    [circleBezPath addArcWithCenter:center radius:12.5 startAngle:-M_PI / 2 endAngle:-M_PI * 3 / 2 clockwise:YES];
//    [circleBezPath addArcWithCenter:center radius:12.5 startAngle:-M_PI * 3 / 2 endAngle:0 clockwise:NO];
//    [circleBezPath addArcWithCenter:center radius:12.5 startAngle:M_PI / 2 endAngle:0 clockwise:NO];
    [circleBezPath addLineToPoint:second];
    [circleBezPath addLineToPoint:third];
    [circleBezPath addLineToPoint:first];
//    [circleBezPath closePath];
    
    // Bezier Full Circle
//    UIBezierPath *fullCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(12.5, 12.5) radius:12.5 startAngle:M_PI * 3 / 2 endAngle:-M_PI * 3 / 2 clockwise:NO];
    UIBezierPath *fullCirclePath = [UIBezierPath bezierPath];
    
    CGPoint circleCenter = CGPointMake(12.5, 12.5);
//    CGPoint circlefirst = CGPointMake(25, 0);
    [fullCirclePath moveToPoint:CGPointMake(12.5, 0)];
    [fullCirclePath addArcWithCenter:circleCenter radius:12.5 startAngle:M_PI * 0.5 endAngle:M_PI * 1.5 clockwise:NO];
    [fullCirclePath addArcWithCenter:circleCenter radius:12.5 startAngle:M_PI * 1.5 endAngle:M_PI * 0.5 clockwise:NO];
    
    
    // NormalPath
    CGMutablePathRef normalPath = CGPathCreateMutable();
    CGPoint firstNormal = CGPointMake(12.5, 0);
    CGPoint secondNormal = CGPointMake(12.5, 25);
    CGPoint thirdNormal = CGPointMake(-12.5, 12.5);
//    CGPoint forthNormal = CGPointMake(-12.5, 12.5);
    CGPathMoveToPoint(normalPath, NULL, secondNormal.x, secondNormal.y);
    CGPathAddLineToPoint(normalPath, NULL, thirdNormal.x, thirdNormal.y);
    CGPathAddLineToPoint(normalPath, NULL, firstNormal.x, firstNormal.y);
    CGPathAddLineToPoint(normalPath, NULL, secondNormal.x, secondNormal.y);
    
    
    // Layer Setting
    CGPathRef firstPath = squarePath.CGPath;
    CGPathRef secondPath = circleBezPath.CGPath;
    CGPathRef thirdPath = normalPath;
    CGPathRef forthPath = fullCirclePath.CGPath;
    
    
//    triangleLayer.path = secondPath;
//    triangleLayer.path = firstPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 1.0;
    animation.fromValue = (__bridge id)firstPath;
//    animation.toValue = (__bridge id)secondPath;
    animation.toValue = (__bridge id)thirdPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    [triangleLayer addAnimation:animation forKey:nil];
    
//    [self.layer addSublayer:triangleLayer];
//    [self.layer addAnimation:animation forKey:nil];
    CFRelease(normalPath);
//    [self.layer addSublayer:[self createPieSlice]];
    
    
    // CAKeyFrameAnimation
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.duration = 1.0;
//    keyAnimation.values = @[(__bridge id)forthPath, (__bridge id)secondPath];
//    keyAnimation.values = @[(__bridge id)secondPath, (__bridge id)forthPath];
//    keyAnimation.values = @[(__bridge id)thirdPath, (__bridge id)secondPath];
    keyAnimation.values = @[(__bridge id)secondPath, (__bridge id)thirdPath];
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.removedOnCompletion = NO;
//    [triangleLayer addAnimation:keyAnimation forKey:nil];
    [self.layer addSublayer:triangleLayer];
    
    CABasicAnimation *originalAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    originalAnimation.duration = 1.0;
//    originalAnimation.fromValue = (__bridge id)secondPath;
    originalAnimation.fromValue = (__bridge id)secondPath;
    originalAnimation.toValue = (__bridge id)thirdPath;
    originalAnimation.fillMode = kCAFillModeForwards;
    originalAnimation.removedOnCompletion = NO;
    
    [triangleLayer addAnimation:[self vacuumAnimation] forKey:nil];
    
    CABasicAnimation *scaleUpAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleUpAnimation.duration = 1.0;
    scaleUpAnimation.fillMode = kCAFillModeForwards;
    scaleUpAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleUpAnimation.toValue = [NSNumber numberWithFloat:10];
    scaleUpAnimation.removedOnCompletion = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [triangleLayer addAnimation:originalAnimation forKey:nil];
//            [triangleLayer addAnimation:scaleUpAnimation forKey:nil];
        });
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            [triangleLayer removeFromSuperlayer];
        });
    });
}

-(void)circleDisappear
{
}

-(CABasicAnimation *)vacuumAnimation
{
    UIBezierPath *circleBezPath = [UIBezierPath bezierPath];
    
    CGPoint centerOne = CGPointMake(0, 0);
    CGPoint centerTwo = CGPointMake(0, 25);
    CGPoint first = CGPointMake(12.5, 0);
    CGPoint second = CGPointMake(12.5, 25);
    CGPoint third = CGPointMake(-12.5, 12.5);
    
    [circleBezPath moveToPoint:first];
    [circleBezPath addLineToPoint:second];
    [circleBezPath addArcWithCenter:centerTwo radius:12.5 startAngle:0 endAngle:M_PI * 3 / 2 clockwise:NO];
    
    
    [circleBezPath moveToPoint:first];
    [circleBezPath addArcWithCenter:centerOne radius:12.5 startAngle:0 endAngle:M_PI / 2 clockwise:YES];
//    [circleBezPath addArcWithCenter:center radius:12.5 startAngle:2 * M_PI endAngle:M_PI / 2 clockwise:YES];
    
    
    UIBezierPath *squarePath = [UIBezierPath bezierPath];
    CGPoint one = CGPointMake(25, 0);
    CGPoint two = CGPointMake(25, 25);
    CGPoint three = CGPointMake(0, 25);
    CGPoint four = CGPointMake(0, 0);
    
    [squarePath moveToPoint:one];
    [squarePath addLineToPoint:two];
    [squarePath addLineToPoint:three];
    [squarePath addLineToPoint:four];
    [squarePath addLineToPoint:one];
    
    CGPathRef onePath = squarePath.CGPath;
    CGPathRef twoPath = circleBezPath.CGPath;
    
    
    CABasicAnimation *originalAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    originalAnimation.duration = 1.0;
    //    originalAnimation.fromValue = (__bridge id)secondPath;
    originalAnimation.fromValue = (__bridge id)onePath;
    originalAnimation.toValue = (__bridge id)twoPath;
    originalAnimation.fillMode = kCAFillModeForwards;
    originalAnimation.removedOnCompletion = NO;
    
    return originalAnimation;
}

-(void)perspectiveAppear
{
    CAAnimationGroup *animationAppear = [CAAnimationGroup animation];
    animationAppear.delegate = self;
    animationAppear.removedOnCompletion = NO;
    animationAppear.duration = 0.7;
    animationAppear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationAppear.repeatCount = 1;
    animationAppear.fillMode = kCAFillModeForwards;
    animationAppear.animations = [NSArray arrayWithObjects:[self perspective3DAnimationwithAngle:-0.3], [self moveStraightX], nil];
    [self.layer addAnimation:animationAppear forKey:@"appear"];
}

-(CAShapeLayer *)createPieSlice
{
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.fillColor = [UIColor yellowColor].CGColor;
    slice.strokeColor = [UIColor blackColor].CGColor;
    slice.lineWidth = 4.0;
    
    CGFloat angle = -M_PI / 6;
    CGPoint center = CGPointMake(10.0, 10.0);
    CGFloat radius = 20.0;
    
    
    CGPathRef fromPath = [self createPieSliceWithCenter:center radius:radius startAngle:-M_PI/6 endAngle:M_PI/6];
    CGPathRef endPath = [self createPieSliceWithCenter:center radius:radius startAngle:M_PI/3 endAngle:-M_PI/3];
    
    slice.path = fromPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 1.0;
    
    animation.fromValue = (__bridge id)fromPath;
    animation.toValue = (__bridge id)endPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [slice addAnimation:animation forKey:nil];
    

    return slice;
}

-(CGPathRef)createPieSliceWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)degStartAngle endAngle:(CGFloat)degEndAngle
{
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center];
    [piePath addLineToPoint:CGPointMake(center.x + radius * cosf(degStartAngle), center.y + radius * sinf(degStartAngle))];
    [piePath addArcWithCenter:center radius:radius startAngle:degStartAngle endAngle:degEndAngle clockwise:YES];
    [piePath closePath];
    
    return piePath.CGPath;
}

-(void)perspectiveDisappear
{
    
}

-(CAAnimation *)perspective3DAnimationwithAngle:(Float32)angle;
{
    CAKeyframeAnimation *perspectiveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transformForword = CATransform3DIdentity;
    transformForword.m34 = -1.0f/200.0f;
    transformForword = CATransform3DRotate(transformForword, angle, 0, 1, 0);
    
    CATransform3D transformBackword = CATransform3DIdentity;
//    transformBackword.m34 = 1.0f/100.0f;
    transformBackword = CATransform3DRotate(transformBackword, 0.0, 0, 1, 0);
    
    NSValue *nonPerspective = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];
    NSValue *perspectiveForword = [NSValue valueWithCATransform3D:transformForword];
    NSValue *perspectiveBackword = [NSValue valueWithCATransform3D:transformBackword];
    
    NSArray *perspectiveArrayforMove = [NSArray arrayWithObjects:perspectiveForword, perspectiveBackword, nonPerspective, nil];
    NSArray *perspectiveArrayforTime = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.6], [NSNumber numberWithFloat:0.7], nil];
    
    [perspectiveAnimation setValues:perspectiveArrayforMove];
    [perspectiveAnimation setKeyTimes:perspectiveArrayforTime];
    [perspectiveAnimation setDuration:0.7];
    [perspectiveAnimation setRemovedOnCompletion:NO];
    [perspectiveAnimation setFillMode:kCAFillModeForwards];
    [perspectiveAnimation setDelegate:self];
    
    return  perspectiveAnimation;
}

-(CAAnimation *)moveStraightX
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    [animation setDuration:0.7];
    [animation setAutoreverses:NO];
    [animation setRemovedOnCompletion:NO];
    [animation setFromValue:[NSNumber numberWithInt:0]];
    [animation setToValue:[NSNumber numberWithInt:20]];
    [animation setDelegate:self];
    
    return  animation;
}

-(void)gcdTest
{
    //            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //            dispatch_group_t group = dispatch_group_create();
    //            for (NSInteger i = 0; i < 15; ++i)
    //            {
    //                dispatch_group_async(group, queue, ^{
    //                    [NSThread sleepForTimeInterval:3];
    //                    NSLog(@"RRR %d", i);
    //                });
    //            }
    ////            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //                NSLog(@"Finish");
    //            });
    
    
    //            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //            dispatch_group_t group = dispatch_group_create();
    //            dispatch_group_async(group, queue, ^{
    //                [NSThread sleepForTimeInterval:1];
    //                NSLog(@"group1");
    //            });
    //            dispatch_group_async(group, queue, ^{
    //                [NSThread sleepForTimeInterval:2];
    //                NSLog(@"group2");
    //            });
    //            dispatch_group_async(group, queue, ^{
    //                [NSThread sleepForTimeInterval:3];
    //                NSLog(@"group3");
    //            });
    //            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //                NSLog(@"updateUi");
    //            });
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 50; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(3);
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
