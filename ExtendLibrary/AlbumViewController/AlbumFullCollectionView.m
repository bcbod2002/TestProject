//
//  AlbumFullCollectionView.m
//  TestProject
//
//  Created by SSPC139 on 2014/12/30.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "AlbumFullCollectionView.h"

@implementation AlbumFullCollectionView
{
    UICollectionView *albumFullCollectionView;
    NSString *albumReuse;
    NSArray *albumImagesArray;
    NSArray *albumFilePathArray;
    NSMutableArray *deleteItemArray;
    NSInteger currentPage;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _deleteTag = NO;
        deleteItemArray = [[NSMutableArray alloc] init];
        albumReuse = @"AlbumFullReuse";
        AlbumFullFlowLayout *albumFullFlowLayout = [[AlbumFullFlowLayout alloc] initWithCollectionViewSize:frame.size];
        albumFullCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:albumFullFlowLayout];
        [albumFullCollectionView registerClass:[AlbumFullCollectionViewCell class] forCellWithReuseIdentifier:albumReuse];
        [albumFullCollectionView setScrollEnabled:YES];
        [albumFullCollectionView setShowsHorizontalScrollIndicator:NO];
        [albumFullCollectionView setShowsVerticalScrollIndicator:NO];
        albumFullCollectionView.delegate = self;
        albumFullCollectionView.dataSource = self;
        [self addSubview:albumFullCollectionView];
        
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
    return 10;
//    return albumFilePathArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumFullCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumReuse forIndexPath:indexPath];
    [cell setFullScrollViewDelegate:self];
    [cell setCellImage:albumImagesArray[indexPath.row]];
    currentPage = indexPath.row;
    return cell;
}

#pragma mark - UICollectionView Delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_deleteTag)
//    {
//        [deleteItemArray addObject:albumFilePathArray[indexPath.row]];
//    }
//}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumFullCollectionViewCell *albumCell = (AlbumFullCollectionViewCell *)cell;
    [albumCell setFullScrollViewZoomOrigin];
}



#pragma mark - UICollectionView Other Operations
-(void)setAlbumImagesContentArray:(NSArray *)imagesArray
{
    albumImagesArray = imagesArray;
    [albumFullCollectionView reloadData];
}

-(void)setAlbumImageFilePathArray:(NSArray *)filePathArray
{
    albumFilePathArray = filePathArray;
}

-(void)deleteAlbumItemFromCurrentPage
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:1];
    [albumFullCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    [deleteItemArray removeObjectAtIndex:currentPage];
    
}

-(void)deleteAlbumItemWithPage:(NSInteger)pageNumber
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNumber inSection:1];
    [albumFullCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    [deleteItemArray removeObjectAtIndex:pageNumber];
}

-(void)dealloc
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
