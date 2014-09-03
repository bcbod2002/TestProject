//
//  PictureManagerView.h
//  MyBell
//
//  Created by shinsoft on 2014/6/25.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "PictureManagerFlowLayout.h"
#import "PictureManagerFullScreenFlowLayout.h"
#import "PictureManagerViewCell.h"
#import "PictureManagerHeaderView.h"


#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    NoneFullScreenFlowLayout,
    FullScreenFlowLayout
}FlowLayoutTag;

@interface PictureManagerView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, MPMediaPickerControllerDelegate, UIAlertViewDelegate>

-(void)reloadAllData;
-(void)deletePicturesWithState:(BOOL)state;

@property (strong, nonatomic) UICollectionView *pictureManagerCollectionView;
@property (strong, nonatomic) NSMutableArray *pictureMutableArray;

@property (strong, nonatomic) NSMutableArray *pictureFiles;
@property (strong, nonatomic) NSMutableArray *videoFiles;
@property (strong, nonatomic) NSMutableArray *moviethumbnailArray;

@property (strong, nonatomic) NSMutableArray *moviePlayerArray;
@property (atomic) FlowLayoutTag flowLayoutTag;

@property (nonatomic) NSInteger counter;
@property (nonatomic) BOOL editButtonState;
@property (nonatomic, strong) NSMutableArray *deletePathArray;
@property (nonatomic, strong) NSMutableArray *nonDeletePathArray;

@end
