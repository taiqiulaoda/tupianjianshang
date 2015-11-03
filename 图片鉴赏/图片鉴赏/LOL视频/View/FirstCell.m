//
//  FirstCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {

        [self _creatUI];
    }
    return self;
}




-(void)_creatUI{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 90, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
}

@end
