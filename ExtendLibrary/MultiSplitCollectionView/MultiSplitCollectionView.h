//
//  MultiSplitCollectionView.h
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSplitCollectionViewCell.h"
#import "OneSplitFlowLayout.h"
#import "FourSplitFlowLayout.h"
#import "NineSplitFlowLayout.h"
#import "SixteenSplitFlowLayout.h"

typedef NS_ENUM (NSInteger, SplitNumber) {
    OneSplitNumber     = 1,
    FoursplitNumber    = 4,
    NineSplitNumber    = 9,
    SixteenSplitNumber = 16
};

@class MultiSplitCollectionView;
@protocol MultiSplitCollectionViewDelegate <NSObject>
@optional
-(void)collectionView:(MultiSplitCollectionView *)collectionView splitFlowLayoutChangeWithSplitNumber:(SplitNumber)splitNumber;
@end

@interface MultiSplitCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MultiSplitCollectionViewCellDelegate>

@property (nonatomic) SplitNumber previousSplitNumber;
@property (nonatomic) SplitNumber nowSplitNumber;
@property (strong, nonatomic) id <MultiSplitCollectionViewDelegate>delegate;
@property (nonatomic) NSInteger totalChannel;
@property (strong, nonatomic, readonly) NSIndexPath *selectedIndexPath;
@property (nonatomic, readonly) NSUInteger nowPage;
@property (nonatomic, readonly) NSUInteger totalPage;

-(void)changeSplitFlowLayout:(SplitNumber)splitnumber;
-(void)setReloadData;
-(void)shrinkCollectionCell;
-(void)amplifyChosenCell;
-(void)condenseChosenCell;

@end
