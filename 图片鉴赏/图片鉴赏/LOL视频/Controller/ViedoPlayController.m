//
//  ViedoPlayController.m
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "ViedoPlayController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"

@interface ViedoPlayController ()<UMSocialUIDelegate>

{
    NSString *str;
    UIImageView *imageView;
}

@end

@implementation ViedoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
 
    [self creatView];
    
    [self loadData];
}

//导航栏按钮

-(void)creatNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(postAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];

}

-(void)postAction:(UIButton*)button{
    NSLog(@"分享");
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"551a5860fd98c513b60002f7" shareText:self.title shareImage:[UIImage imageNamed:self.Secmodel.thumb] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone, nil] delegate:self];
}


-(void)backAction:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];

}

//创建下面的视图
-(void)creatView{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 100,kScreenWidth-10,200)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_Secmodel.thumb]];
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-50)/2, 75, 50, 50);
    [btn setBackgroundImage:[UIImage imageNamed:@"PlayMovie@2x.png"] forState:UIControlStateNormal];
    [imageView addSubview:btn];
    
    
    [btn addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
}

//按钮点击进去播放
-(void)goAction:(UIButton*)button{

    NSLog(@"进去===================");
    MPMoviePlayerViewController * mp = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:str]];
    [self presentViewController:mp animated:YES completion:nil];

}

//请求数据
-(void)loadData{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD showWithOverlay];
    
    NSString *string = [NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/getvideourl?iap=0&ident=1EFB14A9-BC26-497D-A761-D2DE836C3933&jb=0&nc=3435719118&tk=55b9a53452e4994c8e2d83a9207c671d&type=flv&vid=%@",self.Secmodel.myid];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dic);
        str = dic[@"url"];
        
        
        [GiFHUD dismiss];
    }

         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
