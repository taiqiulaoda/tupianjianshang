//
//  DuanziCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DuanziCell.h"

@implementation DuanziCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self create];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}



-(void)setDuanzimodel:(DuanziModel *)duanzimodel{
    if (_duanzimodel != duanzimodel) {
        _duanzimodel = duanzimodel;
    
        _wbodyLabel.text = _duanzimodel.wbody;
    
    }

}

- (void)create
{
    _wbodyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 320, 80)];
    _wbodyLabel.numberOfLines = 0;

    _wbodyLabel.font = [UIFont systemFontOfSize:13];
    _wbodyLabel.textColor = [UIColor whiteColor];
    
    
    [self.contentView addSubview:_wbodyLabel];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
