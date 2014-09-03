//
//  PictureManagerHeaderView.m
//  MyBell
//
//  Created by SSPC139 on 2014/7/9.
//  Copyright (c) 2014年 shinsoft. All rights reserved.
//

#import "PictureManagerHeaderView.h"

@implementation PictureManagerHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width / 2) - 100, (self.frame.size.height / 2) - 7.5, 200, 15)];
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake((320 / 2) - 100, (30 / 2) - 7.5, 200, 15)];
        [_titleLable setTextAlignment:NSTextAlignmentCenter];
        [_titleLable setTextColor:[UIColor whiteColor]];
        [self addSubview:_titleLable];
    }
    return self;
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
