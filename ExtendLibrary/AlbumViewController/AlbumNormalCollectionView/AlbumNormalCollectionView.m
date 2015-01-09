//
//  AlbumNormalCollectionView.m
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import "AlbumNormalCollectionView.h"

@implementation AlbumNormalCollectionView
{
    UICollectionView *albumNormalCollectionView;
    NSString *albumReuse;
    NSArray *albumImageArray;
    NSArray *albumFilePathArray;
    NSMutableArray *deleteItemArray;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _deleteTag = NO;
        deleteItemArray = [[NSMutableArray alloc] init];
        albumReuse = @"AlbumNormalReuse";
        AlbumNormalFlowLayout *albumNormalFlowLayout = [[AlbumNormalFlowLayout alloc] initWithWidthCellNumber:10 WithLineSpacing:5.f AndCollectionViewSize:frame.size];
        albumNormalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:albumNormalFlowLayout];
        [albumNormalCollectionView registerClass:[AlbumNormalCollectionViewCell class] forCellWithReuseIdentifier:albumReuse];
//        [albumNormalCollectionView setPagingEnabled:YES];
        [albumNormalCollectionView setScrollEnabled:YES];
        [albumNormalCollectionView setShowsHorizontalScrollIndicator:NO];
        [albumNormalCollectionView setShowsVerticalScrollIndicator:YES];
        albumNormalCollectionView.delegate = self;
        albumNormalCollectionView.dataSource = self;
        [self addSubview:albumNormalCollectionView];
    }
    return self;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumNormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumReuse forIndexPath:indexPath];
    
//    [cell se]
    
    return cell;
}

#pragma mark - UICollectionView Delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UICollectionView Other Operations
-(void)setAlbumImagesContentArray:(NSArray *)imagesArray
{
    albumImageArray = imagesArray;
    [albumNormalCollectionView reloadData];
}

-(void)setAlbumImageFilePathArray:(NSArray *)filePathArray
{
    albumFilePathArray = filePathArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
