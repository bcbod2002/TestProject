//
//  TestViewControllerTransition.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/9.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestViewControllerTransition.h"

@implementation TestViewControllerTransition

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:desController.view];
    desController.view.alpha = 0.f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        srcController.view.transform = CGAffineTransformMakeTranslation(-srcController.view.bounds.size.width, 0.f);
        desController.view.alpha = 1.f;
    } completion:^(BOOL finished) {
        srcController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2;
}


@end
