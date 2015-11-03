//
//  MovieModel.h
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseModel.h"

@interface MovieModel : BaseModel

@property(nonatomic ,copy)NSString *wbody;//评论
@property(nonatomic ,copy)NSString *likes;
@property(nonatomic ,copy)NSString *vpic_small;
@property(nonatomic ,copy)NSString *vplay_url;
@end
