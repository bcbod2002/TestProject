//
//  AlbumFullCollectionViewCell.h
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumFullCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

#pragma mark - Variables

#pragma mark - Functions
-(void)setCellImage:(UIImage *)cellImage;
-(void)setFullScrollViewDelegate:(id)object;

@end
