//
//  AlbumNormalFlowLayout.h
//  TestProject
//
//  Created by SSPC139 on 2015/1/8.
//  Copyright (c) 2015年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumNormalFlowLayout : UICollectionViewFlowLayout

#pragma mark - Variables

#pragma mark - Functions
-(instancetype)initWithWidthCellNumber:(NSInteger)widthNumber WithLineSpacing:(CGFloat)lineSpacing AndCollectionViewSize:(CGSize)_collectionViewSize;
@end
