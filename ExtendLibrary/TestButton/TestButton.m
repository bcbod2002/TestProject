//
//  TestButton.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/5.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "TestButton.h"

@implementation TestButton
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        <#statements#>
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* strokeColor = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1];
    UIColor* fillColor = [UIColor colorWithRed: 0.439 green: 0.004 blue: 0 alpha: 1];
    
    //// Gradient Declarations
    NSArray* buttonGradientColors = [NSArray arrayWithObjects:
                                     (id)strokeColor.CGColor,
                                     (id)[UIColor colorWithRed: 0.72 green: 0.002 blue: 0 alpha: 1].CGColor,
                                     (id)fillColor.CGColor, nil];
    CGFloat buttonGradientLocations[] = {0, 0.49, 1};
    CGGradientRef buttonGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)buttonGradientColors, buttonGradientLocations);
    
    //// Shadow Declarations
    UIColor* highlight = [UIColor lightTextColor];
    CGSize highlightOffset = CGSizeMake(0.1, 2.1);
    CGFloat highlightBlurRadius = 2;
    
    //// Frames
//    CGRect frame = CGRectMake(0, 0, 480, 49);
    CGRect frame = rect;
    
    
    //// Button
    {
        //// Rounded Rectangle Drawing
        CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 4, floor((CGRectGetWidth(frame) - 4) * 0.99370 + 0.5), floor((CGRectGetHeight(frame) - 4) * 0.91111 + 0.5));
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 6];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, highlightOffset, highlightBlurRadius, highlight.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [roundedRectanglePath addClip];
        CGContextDrawLinearGradient(context, buttonGradient,
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        roundedRectanglePath.lineWidth = 1;
        [roundedRectanglePath stroke];
    }
    
    
    //// Cleanup
    CGGradientRelease(buttonGradient);
    CGColorSpaceRelease(colorSpace);

}


@end
