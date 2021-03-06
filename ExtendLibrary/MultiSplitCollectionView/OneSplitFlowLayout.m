//
//  OneSplitFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/9/3.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import "OneSplitFlowLayout.h"

@implementation OneSplitFlowLayout

-(id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(320, 240);
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
    return CGSizeMake(self.collectionView.frame.size.width * 16, self.collectionView.frame.size.height);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}
@end
