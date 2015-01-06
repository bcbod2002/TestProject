//
//  AlbumFullCollectionViewCell.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullCollectionViewCell.h"

@implementation AlbumFullCollectionViewCell
{
    UIScrollView *fullScrollView;
    UIImageView *fullImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        fullScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [fullImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [fullScrollView addSubview:fullImageView];
        [self.contentView addSubview:fullScrollView];
        
        [self setBackgroundColor:[UIColor orangeColor]];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:2.f];
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    [fullImageView setImage:nil];
}

-(void)setCellImage:(UIImage *)cellImage
{
    [fullImageView setImage:cellImage];
}

-(void)setFullScrollViewDelegate:(id)object
{
    fullScrollView.delegate = object;
}

@end