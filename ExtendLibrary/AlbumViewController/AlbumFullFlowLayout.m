//
//  AlbumFullFlowLayout.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullFlowLayout.h"

@implementation AlbumFullFlowLayout

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
        self.sectionInset = UIEdgeInsetsMake(1.f, 1.f, 1.f, 1.f);
        self.minimumInteritemSpacing = 40.f;
        self.minimumLineSpacing = 40.f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}

//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                //決定 Item 的縮放比例與動畫
                //Decide the scale factor and zoom animations for each item.
                CGFloat zoom = 1 + ZOOM_FACTOR * ( 1 - ABS(normalizedDistance) );
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}
}

@end
