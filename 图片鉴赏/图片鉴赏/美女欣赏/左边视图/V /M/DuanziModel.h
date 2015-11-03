//
//  DuanziModel.h
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface DuanziModel : BaseModel
@property(nonatomic ,copy) NSString *likes;
@property(nonatomic ,copy) NSString *comments;
@property(nonatomic ,copy) NSString *update_time;
@property(nonatomic ,copy) NSString *wbody;
@property(nonatomic ,copy) NSString *wid;

@end
