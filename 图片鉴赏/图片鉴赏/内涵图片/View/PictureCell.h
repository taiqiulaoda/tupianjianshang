//
//  PictureCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@interface PictureCell : UITableViewCell

@property(nonatomic ,copy)UILabel *titleLabel;
@property(nonatomic ,copy)UIImageView *middleImage;

@property(nonatomic ,strong)PictureModel *picturemodel;
@end
