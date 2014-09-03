//
//  PictureManagerViewCell.m
//  MyBell
//
//  Created by SSPC139 on 2014/7/7.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PictureManagerViewCell.h"

UIImageView *pictureView;

@implementation PictureManagerViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.contentView.layer.cornerRadius = 15.0;
//        self.contentView.layer.borderWidth = 1.0f;
//        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.contentView.backgroundColor = [UIColor underPageBackgroundColor];
//        pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [self addSubview:pictureView];
    }
    return self;
}
-(void) setPictureWithImage:(UIImage *)image
{
    [pictureView setImage:image];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
//    [pictureView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    NSLog(@"applyLayoutAttributes picture.size = %f, %f", pictureView.frame.size.width, pictureView.frame.size.height);
}
-(void)willTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout
{
//    NSLog(@"willTransikationfromLayout cell.size = %f, %f", self.frame.size.width, self.frame.size.height);
//    [pictureView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}
-(void)didTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout
{
//    NSLog(@"didTransikationfromLayout cell.size = %f, %f", self.frame.size.width, self.frame.size.height);
//    [pictureView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    NSLog(@"didTransikationfromLayout picture.size = %f, %f", pictureView.frame.size.width, pictureView.frame.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
