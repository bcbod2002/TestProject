//
//  PictureManagerFlowLayout.m
//  MyBell
//
//  Created by SSPC139 on 2014/7/4.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PictureManagerFlowLayout.h"

@implementation PictureManagerFlowLayout

//-(CGSize)collectionViewContentSize
//{
//    return <#expression#>;
//}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(77, 77);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(4, 0, 15, 0);
        self.minimumLineSpacing = 4;
        self.minimumInteritemSpacing = 4;
        self.headerReferenceSize = CGSizeMake(320, 30);
        
        
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


//-(void)prepareLayout
//{
//    [super prepareLayout];
//    
//    _cellCount = [[self collectionView] numberOfItemsInSection:0];
//    
//}

//-(CGSize)collectionViewContentSize
//{
//    return CGSizeMake(80, 80);
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
//    attributes.size = CGSizeMake(77, 77);
////    attributes.center = CGPointMake(10, 10);
//    
//    return attributes;
//}

-(void)prepareForAnimatedBoundsChange:(CGRect)oldBounds
{
    NSLog(@"prepareforAnimatedBoundsChange  Old");
}


//-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//////    NSLog(@"array = %@", array);
////    CGRect visibleRect;
////    visibleRect.origin = self.collectionView.contentOffset;
////    visibleRect.size = self.collectionView.bounds.size;
////    
//////    for (UICollectionViewLayoutAttributes *attributes in array)
//////    {
//////        if (CGRectIntersectsRect(attributes.frame, rect))
//////        {
//////            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//////            CGFloat normalizedDistance = distance / 100;
//////            if (ABS(distance) < 100)
//////            {
//////                CGFloat zoom = 1 + 0.2 * (1 - ABS(normalizedDistance));
//////                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//////                attributes.zIndex = 1;
//////            }
//////        }
//////    }
//    return array;
//}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    //    NSLog(@"attribute.center = %f, %f", attributes.size.width, attributes.size.height);
//    attributes.size = CGSizeMake(77, 77);
//    [[self.collectionView cellForItemAtIndexPath:indexPath].subviews[1] setFrame:CGRectMake(0, 0, 77, 77)];
//    NSLog(@"attributes normal= %@", attributes);
////    NSLog(@"Layout Normal");
//    return attributes;
//}


-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
//    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 1.0);
//    
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    
////    for (UICollectionViewLayoutAttributes *layoutAttributes in array)
////    {
////        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
////        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
////        {
////            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
////        }
////    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

//-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
////    attributes.alpha = 1.0;
////    attributes.center = CGPointMake(10, 10);
//    NSLog(@"[self.collectionView cellForItemAtIndexPath:itemIndexPath] = %@", [self.collectionView cellForItemAtIndexPath:itemIndexPath]);
//    
//    
//    
//    return attributes;
//}
//
//-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//    
//    return attributes;
//}

@end
