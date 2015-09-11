//
//  MultiSplitCollectionViewCell.h
//  TestProject
//
//  Created by shinsoft on 2014/5/30.
//  Copyright (c) 2014年 Goston. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiSplitCollectionViewCell;
@protocol MultiSplitCollectionViewCellDelegate <NSObject>
@required
-(void)didDoubleTapCell;

@end

@interface MultiSplitCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (strong, nonatomic) id <MultiSplitCollectionViewCellDelegate> delegate;
@property (strong, nonatomic, readwrite) NSIndexPath *indexPath;

-(void)cellTransformParallelogram;

@end
