//
//  MovieCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}
//
//@property(nonatomic ,copy)NSString *wbody;//评论
//@property(nonatomic ,copy)NSString *likes;
//@property(nonatomic ,copy)NSString *vpic_small;

-(void)setMoviemodel:(MovieModel *)moviemodel{
    if (_moviemodel != moviemodel) {
        _moviemodel = moviemodel;
        
        _titleLabel.text = _moviemodel.wbody;
        _titleLabel.numberOfLines = 0;
        
        
        [_movieLabel sd_setImageWithURL:[NSURL URLWithString:_moviemodel.vpic_small] placeholderImage:[UIImage imageNamed:@"Icon-Spotlight-40@3x"]];
        _movieLabel.layer.cornerRadius = 10;
        _movieLabel.layer.masksToBounds = YES;
        _likeLabel.text = [NSString stringWithFormat:@"👍:%@",_moviemodel.likes];
    
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
