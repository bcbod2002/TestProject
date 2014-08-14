//
//  MaterialButton.m
//  TestProject
//
//  Created by SSPC139 on 2014/8/12.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "MaterialButton.h"

@implementation MaterialButton
{
    CGPoint tapLocation;
    CALayer *circleAmplifyLayer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        circleAmplifyLayer = [[CALayer alloc] init];
//        [circleAmplifyLayer setFrame:CGRectMake(tapLocation.x - (self.frame.size.width / 2), tapLocation.y - (self.frame.size.width / 2), self.frame.size.width, self.frame.size.width)];
        [circleAmplifyLayer setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5].CGColor];
        [circleAmplifyLayer setOpacity:0];
        [circleAmplifyLayer setCornerRadius:self.frame.size.width / 2];
        [self.layer insertSublayer:circleAmplifyLayer atIndex:0];
        
        [self addTarget:self action:@selector(eventTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(eventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(eventTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(eventTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:nil];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}


#pragma mark - Gesture Delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    tapLocation = [touch locationInView:self];
    [circleAmplifyLayer setFrame:CGRectMake(tapLocation.x - (self.frame.size.width / 2), tapLocation.y - (self.frame.size.width / 2), self.frame.size.width, self.frame.size.width)];
    return NO;
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//}

#pragma mark - IBAction CallBack Handlers
-(void)eventTouchDown:(id)sender
{
    [self buttonTouchDownAnimatiom];
}

-(void)eventTouchUpInside:(id)sender
{
    
}

-(void)eventTouchUpOutside:(id)sender
{
    
}

-(void)eventTouchCancel:(id)sender
{
    
}

#pragma mark - CAAnimation
-(void)buttonTouchDownAnimatiom
{
    CABasicAnimation *circleAmplifyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circleAmplifyAnimation.delegate = self;
    [circleAmplifyAnimation setValue:@"circleAmplify" forKey:@"animationType"];
    circleAmplifyAnimation.duration = 0.5;
    circleAmplifyAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    circleAmplifyAnimation.toValue = [NSNumber numberWithFloat:1.f];
    circleAmplifyAnimation.fillMode = kCAFillModeForwards;
    circleAmplifyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    circleAmplifyAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *circleOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    circleOpacityAnimation.delegate = self;
    [circleOpacityAnimation setValue:@"circleOpacity" forKey:@"animationType"];
    circleOpacityAnimation.duration = 0.5;
    circleOpacityAnimation.fromValue = [NSNumber numberWithFloat:0.5f];
    circleOpacityAnimation.toValue = [NSNumber numberWithFloat:0.f];
    circleOpacityAnimation.fillMode = kCAFillModeForwards;
    circleOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    circleOpacityAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *amplifyOpacityGroupAnimation = [CAAnimationGroup animation];
    amplifyOpacityGroupAnimation.delegate = self;
    [amplifyOpacityGroupAnimation setValue:@"amplifyOpacityGroup" forKey:@"animationType"];
    amplifyOpacityGroupAnimation.animations = @[circleAmplifyAnimation, circleOpacityAnimation];
    amplifyOpacityGroupAnimation.duration = 0.5;
    
    [circleAmplifyLayer addAnimation:amplifyOpacityGroupAnimation forKey:@"amplifyOpacityGroup"];
}

-(void)buttonTextAnimation
{
    
}

#pragma mark - Animation Delgate
-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if ([[anim valueForKey:@"animationType"] isEqual:@"amplifyOpacityGroup"])
//    {
//        [self.layer.sublayers[0] removeAllAnimations];
//        [self.layer.sublayers[0] removeFromSuperlayer];
//    }
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
