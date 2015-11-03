//
//  SecondModel.h
//  图片鉴赏
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface SecondModel : BaseModel
@property (copy,nonatomic) NSString *author;
@property (copy,nonatomic) NSString *thumb;//头像
@property (copy,nonatomic) NSString *title;//标题
@property (copy,nonatomic) NSString *myid;
@property (copy,nonatomic) NSString *time;//时长
@property (copy,nonatomic) NSString *date;//发布时间
@end
