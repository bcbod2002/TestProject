//
//  AlbumNormalFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "AlbumNormalFlowLayout.h"

@implementation AlbumNormalFlowLayout
{
    CGSize collectionViewSize;
}

-(instancetype)initWithWidthCellNumber:(NSInteger)widthNumber WithLineSpacing:(CGFloat)lineSpacing AndCollectionViewSize:(CGSize)_collectionViewSize
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = lineSpacing;
        self.minimumInteritemSpacing = lineSpacing;
        self.sectionInset = UIEdgeInsetsMake(lineSpacing, lineSpacing, lineSpacing, lineSpacing);
        collectionViewSize = _collectionViewSize;
        CGFloat caculateSpacing = (lineSpacing * (widthNumber + 1));
        self.itemSize = CGSizeMake((collectionViewSize.width - caculateSpacing) / widthNumber, (collectionViewSize.width - caculateSpacing) / widthNumber);
    }
    return self;
}

-(void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];

    return attributesArray;
}

//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    
//}


@end
