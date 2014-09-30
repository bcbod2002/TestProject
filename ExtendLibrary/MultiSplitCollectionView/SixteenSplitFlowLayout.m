//
//  SixteenSplitFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/9/3.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "SixteenSplitFlowLayout.h"

@implementation SixteenSplitFlowLayout

-(id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(80, 60);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsZero;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
