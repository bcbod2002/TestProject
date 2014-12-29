//
//  SHINPictureManagerCtrller.h
//  EasyCam
//
//  Created by shinsoft on 2014/1/27.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#define FILETYPE @"IMG"

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AlbumFullViewController.h"
#import "PictureManagerHeaderView.h"
#import "PictureManagerViewCell.h"
#import "PictureManagerFlowLayout.h"


@interface SHINPictureManagerCtrller : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate, UIAlertViewDelegate>

- (IBAction)editButtonAction:(id)sender;

@end