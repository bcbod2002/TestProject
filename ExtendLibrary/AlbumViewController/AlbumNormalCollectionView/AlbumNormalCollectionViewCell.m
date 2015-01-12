//
//  AlbumNormalCollectionViewCell.m
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "AlbumNormalCollectionViewCell.h"

@implementation AlbumNormalCollectionViewCell
{
    UIImageView *normalImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        /**
         *  Initial UIImageView for Picture
         */
        normalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [normalImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
//        [normalImageView setBackgroundColor:[UIColor blueColor]];
        [normalImageView setAlpha:0.8f];
        [self.layer setShouldRasterize:YES];
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self setBackgroundColor:[UIColor greenColor]];
        [self.contentView setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:normalImageView];
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [normalImageView setImage:nil];
}

-(void)setCellImage:(UIImage *)cellImage
{
    [normalImageView setImage:cellImage];
}



@end
