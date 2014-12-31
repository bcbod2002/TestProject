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
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumFullCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:albumReuse forIndexPath:indexPath];
//    [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, self.frame.size.width, self.frame.size.height)];
//    [cell setFrame:CGRectMake(cell.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    [cell setFullScrollViewDelegate:self];
    [cell setCellImage:albumImagesArray[indexPath.row]];
    NSLog(@"RRRRR");
    return cell;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_deleteTag)
    {
        [deleteItemArray addObject:albumFilePathArray[indexPath.row]];
    }
}

#pragma mark - UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return nil;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
