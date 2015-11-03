//
//  SecondCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"
@interface SecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property(nonatomic ,strong) SecondModel *secondmodel;
@end
