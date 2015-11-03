//
//  WallCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallModel.h"
@interface WallCell : UITableViewCell<UIAlertViewDelegate>
@property(nonatomic ,strong)UIImageView *wallimage;

@property(nonatomic ,strong)WallModel *wallmodel;
@end
