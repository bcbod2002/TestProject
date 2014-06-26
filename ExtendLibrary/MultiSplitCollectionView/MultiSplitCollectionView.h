//
//  MultiSplitCollectionView.h
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiSplitCollectionView : UICollectionView

-(void)extendCollectionCellWithSplitNumber:(NSInteger) splitNumber;
-(void)shrinkCollectionCell;
-(void)amplifyChosenCell;
-(void)condenseChosenCell;

@end
