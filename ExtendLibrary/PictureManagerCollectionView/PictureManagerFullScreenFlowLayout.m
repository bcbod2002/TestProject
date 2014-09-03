//
//  PictureManagerFullScreenFlowLayout.m
//  MyBell
//
//  Created by SSPC139 on 2014/7/11.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PictureManagerFullScreenFlowLayout.h"

@implementation PictureManagerFullScreenFlowLayout

-(id)init
{
    self = [super init];
    if (self)
    {
//        self.itemSize = CGSizeMake(320, 328);
        self.itemSize = CGSizeMake(320, 240);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        NSLog(@"FullScreenFlowLayout init");
    }
    return  self;
}

-(void)prepareLayout
{
    [super prepareLayout];
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(320, 240);
//}

//-(CGSize)collectionViewContentSize
//{
//    return CGSizeMake(320, 240);
//}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    
//}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
////    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
////    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
////                                    _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
////    return attributes;
//    
//    
//    
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
////    NSLog(@"attribute.center = %f, %f", attributes.size.width, attributes.size.height);
//    attributes.size = CGSizeMake(320, 240);
//    [[self.collectionView cellForItemAtIndexPath:indexPath].subviews[1] setFrame:CGRectMake(0, 0, 320, 240)];
//    if (indexPath.section == 1)
//    {
//        NSLog(@"indexPath.row = %d", indexPath.row);
//    }
//    return attributes;
//}

//-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
////    NSLog(@"layoutAttributesForElementsInRect = %f, %f", rect.size.width, rect.size.height);
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
////    CGRect visileRect;
//////    visileRect.origin = self.collectionView.contentOffset;
//////    visileRect.size = self.collectionView.bounds.size;
//    
//    
//    
//    return array;
//}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
//    CGFloat offsetAdjustment = MAXFLOAT;
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSLog(@"proposedContentOffset = %f, %f", proposedContentOffset.x , proposedContentOffset.y);
    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y);
//    return CGPointMake(0, 0);
}
@end
