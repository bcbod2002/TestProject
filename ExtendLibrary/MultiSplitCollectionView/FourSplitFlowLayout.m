//
//  FourSplitFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/9/3.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "FourSplitFlowLayout.h"

@implementation FourSplitFlowLayout

-(id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(160, 120);
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

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width * 4, self.collectionView.frame.size.height);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}
@end