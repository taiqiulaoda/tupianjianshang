//
//  DuanziCell.h
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuanziModel.h"
@interface DuanziCell : UITableViewCell


@property(nonatomic ,retain)UILabel *wbodyLabel;

@property(nonatomic ,strong)DuanziModel *duanzimodel;
@end
