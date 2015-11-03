//
//  PictureModel.h
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface PictureModel : BaseModel

@property(nonatomic ,copy)NSNumber *wpic_m_height;//中图
@property(nonatomic ,copy)NSNumber *wpic_m_width;
@property(nonatomic ,copy)NSString *wpic_middle;
@property(nonatomic ,copy)NSString *wbody;//内涵文字
@property(nonatomic ,copy)NSString *is_gif;

@end
