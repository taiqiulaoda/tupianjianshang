//
//  GirlCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GirlModel.h"

@interface GirlCell : UITableViewCell<UIAlertViewDelegate>

@property(nonatomic ,retain)UIImageView * bigImage;
@property(nonatomic ,retain)UILabel * titleLabel;

@property(nonatomic ,strong)GirlModel *girlmodel;
@end
