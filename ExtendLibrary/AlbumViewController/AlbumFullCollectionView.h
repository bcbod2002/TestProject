//
//  AlbumFullCollectionView.h
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumFullCollectionViewCell.h"
#import "AlbumFullFlowLayout.h"

@interface AlbumFullCollectionView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - Variables
@property (nonatomic) BOOL deleteTag;

#pragma mark - Functions
-(void)setAlbumImagesContentArray:(NSArray *)imagesArray;
-(void)setAlbumImageFilePathArray:(NSArray *)filePathArray;
-(void)deleteAlbumItemFromCurrentPage;
-(void)deleteAlbumItemWithPage:(NSInteger)pageNumber;

@end
