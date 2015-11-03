//
//  GirlCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "GirlCell.h"
#import "SJAvatarBrowser.h"

@implementation GirlCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}




-(void)setGirlmodel:(GirlModel *)girlmodel{

    if (_girlmodel != girlmodel) {
        _girlmodel = girlmodel;
        _titleLabel.text = _girlmodel.wbody;
        
         [_bigImage sd_setImageWithURL:[NSURL URLWithString:_girlmodel.wpic_large] placeholderImage:[UIImage imageNamed:@"123456"]];
    }
}

-(void)creatView{

    _bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
   
    [self.contentView addSubview:_bigImage];
    _bigImage.userInteractionEnabled = YES;
    
    //长按保存到相册
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(downPicture:)];
    
    [_bigImage addGestureRecognizer:longpress];
    
    
    //点击放大图片
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPicture:)];
    
    [_bigImage addGestureRecognizer:tap];
    
    
    
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleLabel];

}
-(void)downPicture:(UIGestureRecognizer*)button{

    if (button.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImage *image = self.bigImage.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"报告,处理好了");

}



-(void)tapPicture:(UITapGestureRecognizer*)tap{
    //单击放大图片
    [SJAvatarBrowser showImage:(UIImageView*)tap.view];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
