//
//  PictureManagerFlowLayout.h
//  MyBell
//
//  Created by SSPC139 on 2014/7/4.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PictureManagerFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) NSInteger cellCount;
@property (strong, nonatomic) NSMutableArray *indexPathToAnimation;
@property (strong, nonatomic) NSIndexPath *pinchItem;

@end
