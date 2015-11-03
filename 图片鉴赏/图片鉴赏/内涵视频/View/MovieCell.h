//
//  MovieCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property(nonatomic ,strong)MovieModel *moviemodel;

@end
