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
    UIDynamicAnimator *dynamicAnimator;
    NSMutableSet *visibleIndexPathSet;
    CGFloat latestDelta;
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
        self.headerReferenceSize = CGSizeMake(_collectionViewSize.width, ((collectionViewSize.width - caculateSpacing) / widthNumber) / 2);
        dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        visibleIndexPathSet = [NSMutableSet set];
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGRect visibleRect = CGRectInset((CGRect){.origin = self.collectionView.bounds.origin, .size = self.collectionView.frame.size}, -100, -100);
    NSArray *itemInVisibleRectArray = [super layoutAttributesForElementsInRect:visibleRect];
    NSSet *itemIndexPathInVisibleRectSet = [NSSet setWithArray:[itemInVisibleRectArray valueForKey:@"indexPath"]];
    
    NSArray *nolongerVisibleBehaviors = [dynamicAnimator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *berhavior, NSDictionary *bindings) {
        BOOL currentlyVisible = [itemIndexPathInVisibleRectSet member:[[[berhavior items] firstObject] indexPath]] != nil;
        return !currentlyVisible;
    }]];
    [nolongerVisibleBehaviors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dynamicAnimator removeBehavior:obj];
        [visibleIndexPathSet removeObject:[[[obj items] firstObject] indexPath]];
    }];
    
    NSArray *newVisibleItems = [itemInVisibleRectArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *item, NSDictionary *bindings) {
        BOOL currentlyVisible = [visibleIndexPathSet member:item.indexPath] != nil;
        return !currentlyVisible;
    }]];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [newVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger idx, BOOL *stop) {
        CGPoint center = item.center;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:center];
        
        springBehavior.length = 0.f;
        springBehavior.damping = 0.8f;
        springBehavior.frequency = 1.0f;
        
        if (!CGPointEqualToPoint(CGPointZero, touchLocation))
        {
            CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
            CGFloat xDistanceFrouTouch = fabsf(touchLocation.x - springBehavior.anchorPoint.x);
            CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFrouTouch) / 1500.f;
            
            if (latestDelta < 0)
            {
                center.y += MAX(latestDelta, latestDelta * scrollResistance);
                
            }
            else
            {
                center.y += MIN(latestDelta, latestDelta * scrollResistance);
            }
            item.center = center;
        }
        [dynamicAnimator addBehavior:springBehavior];
        [visibleIndexPathSet addObject:item.indexPath];
    }];
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    latestDelta = delta;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    [dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehavior, NSUInteger idx, BOOL *stop){
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehavior.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.f;
        
        UICollectionViewLayoutAttributes *item = [springBehavior.items firstObject];
        CGPoint center = item.center;
        if (delta < 0)
        {
            center.y += MAX(delta, delta * scrollResistance);
        }
        else
        {
            center.y += MIN(delta, delta * scrollResistance);
        }
        item.center = center;
        [dynamicAnimator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [dynamicAnimator itemsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}



//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    
//}


@end
