//
//  SecondCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setSecondmodel:(SecondModel *)secondmodel{
    if (_secondmodel != secondmodel) {
        _secondmodel = secondmodel;
        _timeLabel.text = _secondmodel.time;
        
       _nameLabel.text = _secondmodel.title;
        _nameLabel.numberOfLines = 0;


        
        _outLabel.text = [NSString stringWithFormat:@"发布时间:%@",_secondmodel.date];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_secondmodel.thumb]];
        _iconImageView.layer.cornerRadius = 10;
        _iconImageView.layer.masksToBounds = YES;

    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
