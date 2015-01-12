//
//  AlbumNormalHeaderCollectionReusableView.m
//  TestProject
//
//  Created by SSPC139 on 2015/1/12.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "AlbumNormalHeaderCollectionReusableView.h"

@implementation AlbumNormalHeaderCollectionReusableView
{
    UILabel *dateLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:20.f]];
        [dateLabel setNumberOfLines:0];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:dateLabel];
    }
    return self;
}

-(void)setTitleText:(NSString *)text
{
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20.f]}];
    [dateLabel setFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    [dateLabel setText:text];
}

@end
