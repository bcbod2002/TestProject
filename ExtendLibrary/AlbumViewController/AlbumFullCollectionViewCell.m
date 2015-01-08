//
//  AlbumFullCollectionViewCell.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullCollectionViewCell.h"

#define imageProportion 3 / 4

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

        [self.contentView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        /**
         *  Initial UIScrollView for Zoom Out
         */
        fullScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [fullScrollView setContentSize:frame.size];
        [fullScrollView setContentInset:UIEdgeInsetsZero];
        [fullScrollView setMaximumZoomScale:3.f];
        [fullScrollView setMinimumZoomScale:1.f];
        [fullScrollView setDelegate:self];
        
        /**
         *  Initial UIImageView for Picture
         */
        CGFloat imageHeight = frame.size.width * imageProportion;
        fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height - imageHeight) / 2, frame.size.width, imageHeight)];
        [fullImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [fullScrollView addSubview:fullImageView];
        [self.contentView addSubview:fullScrollView];
        
        /**
         *  Other Color for Test
         */        
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

-(void)setFullScrollViewZoomOrigin
{
    [fullScrollView setZoomScale:1.0f];
}

#pragma mark - UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return fullImageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    fullImageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
}

@end