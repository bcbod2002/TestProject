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
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [self.contentView setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        fullScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -((screenSize.height / 2) - 120), screenSize.width, screenSize.height)];
        [fullScrollView setContentSize:frame.size];
        [fullScrollView setMaximumZoomScale:2.f];
        [fullScrollView setMinimumZoomScale:1.f];
        [fullScrollView setDelegate:self];
        fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [fullImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [fullScrollView addSubview:fullImageView];
        [self.contentView addSubview:fullScrollView];
        
        [fullScrollView setBackgroundColor:[UIColor purpleColor]];
        
        [fullImageView setBackgroundColor:[UIColor orangeColor]];
        [fullImageView setAlpha:0.4];
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
//    fullScrollView.delegate = object;
}

#pragma mark - UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return fullImageView;
}

@end