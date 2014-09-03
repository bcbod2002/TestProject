//
//  MultiSplitCollectionView.h
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSplitCollectionViewCell.h"
#import "OneSplitFlowLayout.h"
#import "FourSplitFlowLayout.h"
#import "NineSplitFlowLayout.h"
#import "SixteenSplitFlowLayout.h"

typedef enum {
    OneSplitNumber     = 1,
    FoursplitNumber    = 4,
    NineSplitNumber    = 9,
    SixteenSplitNumber = 16
}SplitNumber;

@class MultiSplitCollectionView;
@protocol MultiSplitCollectionViewDelegate <NSObject>
@optional
-(void)splitFlowLayoutChangeFinished;
@end

@interface MultiSplitCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSInteger numberOfItems;
@property (nonatomic) SplitNumber previousSplitNumber;
@property (strong, nonatomic) id <MultiSplitCollectionViewDelegate>delegate;

-(void)extendCollectionCellWithSplitNumber:(NSInteger) splitNumber;
-(void)shrinkCollectionCell;
-(void)amplifyChosenCell;
-(void)condenseChosenCell;

@end
