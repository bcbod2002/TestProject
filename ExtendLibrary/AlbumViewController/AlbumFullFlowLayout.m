//
//  AlbumFullFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullFlowLayout.h"

#define ACTIVE_DISTANCE 200 //200
#define ZOOM_FACTOR 0.3
#define ITEM_SIZE 200.0
@implementation AlbumFullFlowLayout
{
    CGSize collectionViewSize;
}

-(instancetype)initWithCollectionViewSize:(CGSize)_collectionViewSize
{
    self = [super init];
    if (self)
    {
        collectionViewSize = _collectionViewSize;
        self.itemSize = CGSizeMake(collectionViewSize.width, collectionViewSize.height);
    }
    
    return self;
}

-(void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 2;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attribute in attributesArray)
    {
        CGFloat distance = CGRectGetMidX(visibleRect) - attribute.center.x;
        if (ABS(distance) > 0.503106)
        {
            CGFloat zoomOut = 1 - 0.6 * (ABS(distance) / 322);
            attribute.transform3D = CATransform3DMakeScale(zoomOut, zoomOut, 1.f);
            attribute.zIndex = 1.f;
        }
        attribute.alpha = 0.4;
    }
    return attributesArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes* layoutAttributes in array)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;

        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}



@end
