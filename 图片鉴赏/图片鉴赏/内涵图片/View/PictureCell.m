//
//  PictureCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setPicturemodel:(PictureModel *)picturemodel{
    if (_picturemodel != picturemodel) {
        _picturemodel = picturemodel;
        _titleLabel.text = _picturemodel.wbody;
        [_middleImage sd_setImageWithURL:[NSURL URLWithString:_picturemodel.wpic_middle] placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    }

}

-(void)creat{
    
    _middleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 200)];
    [self.contentView addSubview:_middleImage];

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
