//
//  AlbumFullFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullFlowLayout.h"

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3
#define ITEM_SIZE 200.0

@implementation AlbumFullFlowLayout

-(instancetype)initWithCollectionViewSize:(CGSize)collectionViewSize
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(collectionViewSize.width / 1.3, collectionViewSize.height / 1.3);
//        self.itemSize = CGSizeMake(200, 200);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.
//        self.sectionInset = UIEdgeInsetsMake(200.f, 0.f, 200.f, 0.f);
        self.minimumLineSpacing = 10.f;
    }
    
    return self;
}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray* array = [super layoutAttributesForElementsInRect:rect];
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
//
//    for (UICollectionViewLayoutAttributes* attributes in array)
//    {
//        if (CGRectIntersectsRect(attributes.frame, rect))
//        {
//            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
//            if (ABS(distance) < ACTIVE_DISTANCE)
//            {
//                CGFloat zoom = 1 + 0.3*(1 - ABS(normalizedDistance));
//                NSLog(@"zoom = %f", zoom);
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.zIndex = 1;
//            }
//        }
//    }
//    return array;
//}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"attributesArray = %@", attributesArray);
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attribute in attributesArray)
    {
//        [attribute setFrame:CGRectMake(attribute.frame.origin.x, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height)];
//        if (CGRectIntersectsRect(attribute.frame, rect))
//        {
            CGFloat distance = CGRectGetMidX(visibleRect) - attribute.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 0.8);
                attribute.zIndex = 1;
            }
//        }
    }
    return attributesArray;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
//    NSLog(@"proposedContentOffset.x = %f", proposedContentOffset.x);
//    NSLog(@"velocity = %f", velocity.x);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSLog(@"targetRect = %f", targetRect.origin.x);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    NSLog(@"array.count = %ld", array.count);
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
//    NSLog(@"offsetAdjustment = %f", offsetAdjustment);
//    NSLog(@"proposedContentOffset.x + offsetAdjustment = %f", proposedContentOffset.x + offsetAdjustment);
    NSLog(@"proposedContentOffset.x + offsetAdjustment = %f", proposedContentOffset.x + offsetAdjustment);
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//    NSInteger page = ceil(proposedContentOffset.x / self.collectionView.frame.size.width);
//    return CGPointMake(page * self.collectionView.frame.size.width - 100, 0);
}

@end
