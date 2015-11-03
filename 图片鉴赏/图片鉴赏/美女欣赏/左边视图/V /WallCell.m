//
//  WallCell.m
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WallCell.h"

@implementation WallCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creat];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}


-(void)setWallmodel:(WallModel *)wallmodel{
    if (_wallmodel != wallmodel) {
        _wallmodel = wallmodel;
 
        [_wallimage sd_setImageWithURL:[NSURL URLWithString:_wallmodel.thumb] placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    }

}


-(void)creat{
    _wallimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.contentView addSubview:_wallimage];
    
    _wallimage.userInteractionEnabled = YES;
    
    
    //长按保存
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
    [_wallimage addGestureRecognizer:longpress];
    

}

//保存图片到相册
-(void)longAction:(UIGestureRecognizer*)button{
    if (button.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        UIImage *image = self.wallimage.image;
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
       
        
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    
    NSLog(@"处理完毕");
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
