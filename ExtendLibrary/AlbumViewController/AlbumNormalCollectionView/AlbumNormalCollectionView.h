//
//  AlbumNormalCollectionView.h
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumNormalFlowLayout.h"
#import "AlbumNormalCollectionViewCell.h"
#import "AlbumNormalHeaderCollectionReusableView.h"

@interface AlbumNormalCollectionView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - Variables
@property (nonatomic) BOOL deleteTag;
@property (nonatomic) NSInteger widthCellNumber;

#pragma mark - Functions
-(instancetype)initWithFrame:(CGRect)frame WithWidthCellNumber:(NSInteger)cellNumber;
-(void)setAlbumImagesContentArray:(NSArray *)imagesArray;
-(void)setAlbumImageFilePathArray:(NSArray *)filePathArray;
-(void)setAlbumDateArray:(NSArray *)dateArray WithDateFormatter:(NSDateFormatter *)dateFormatter;

@end
