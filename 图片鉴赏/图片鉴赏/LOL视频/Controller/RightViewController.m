//
//  RightViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/25.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "RightViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UMSocial.h"
#import "SDImageCache.h"
#import "CollectViewController.h"
#import "MapViewController.h"


@interface RightViewController ()
{
    UILabel *_nameLabel;
    UIImageView *_imageView;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
  
    //添加返回按钮
    [self _creatBack];
    //添加下面功能按钮
    [self creatButton];
    
    [self creatIcon];
}
//创建返回按钮
-(void)_creatBack{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"breaking_news_bkg_red@2x"];
    [self.view addSubview:imageView];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 44, 60, 30);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:btn];
    
    
    //开启交互
    imageView.userInteractionEnabled = YES;
    
    

}

-(void)backButton:(UIButton*)button{

    MMDrawerController * mm = self.mm_drawerController;
    [mm closeDrawerAnimated:YES completion:nil];

}

//创建登录头像
-(void)creatIcon{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth/2-20, 50, 40, 40);
    button.layer.cornerRadius = button.frame.size.width / 2;
    button.clipsToBounds = YES;

    
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    _imageView = [[UIImageView alloc]initWithFrame:button.bounds];

    [button addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 90, 120, 40)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_nameLabel];
    
    
    //数据本地化存储
    NSUserDefaults *iconView = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *iconName = [NSUserDefaults standardUserDefaults];
    
    if (![iconName objectForKey:@"username"]) {
        _nameLabel.text = @"用户";
        _imageView.image = [UIImage imageNamed:@"head@2x.png"];
    }else{
        _nameLabel.text = [iconName objectForKey:@"username"];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[iconView objectForKey:@"iconURL"]]];
    }

}
//登录
-(void)loginAction:(UIButton*)button{
    NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
    if (![username objectForKey:@"username"]) {
        [self creatLanded];
    }

}


-(void)creatButton{
    NSArray *items = @[@"收藏",@"地图",@"反馈",@"关于",@"清理内存",@"退出登录"];
    
    CGFloat itemHeight = (kScreenHeight-300)/items.count;
    for (int i = 0; i < items.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(110,i*itemHeight+200 , 90, 20);
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }


}
//功能按钮
-(void)btnAction:(UIButton*)button{
    int index =(int) button.tag;
    if (index == 100) {
        CollectViewController *coll = [[CollectViewController alloc]init];
        [self presentViewController:coll animated:YES completion:nil];
    }
    if (index == 101) {
        MapViewController *mvc = [[MapViewController alloc]init];
        [self presentViewController:mvc animated:YES completion:nil];
    }
    if (index == 102) {
         NSString *string = @"有好的建议或者发现程序BUG可发邮件到2524920054@qq.com或者475980563@qq.com";
        [self showContent:string];
    }
    if (index == 103) {
         NSString *string = @"本应用是不含广告的1.0版本,其中可能有不可预知的BUG,本应用多图多视频建议在Wi-Fi环境下使用";
        [self showContent:string];
    }
    if (index == 104) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [self viewDidLoad];
        UIAlertView *alertView = [[UIAlertView alloc] init];
        NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
        [username removeObjectForKey:@"username"];
        NSUserDefaults *iconURL = [[NSUserDefaults alloc]init];
        [iconURL removeObjectForKey:@"iconURL"];
        alertView.message = @"内存清理成功";
        [alertView addButtonWithTitle:@"确定"];
        [alertView show];
    }
    if (index == 105) {
        //退出登录
        NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
        [username removeObjectForKey:@"username"];
        NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
        [iconURL removeObjectForKey:@"iconURL"];
    }
    _nameLabel.text = @"登录";
    _imageView.image = [UIImage imageNamed:@"head@2x.png"];
}


-(void)creatLanded{

    //三方文档微博接入
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            NSUserDefaults *iconName = [NSUserDefaults standardUserDefaults];
            [iconName setObject:snsAccount.userName forKey:@"username"];
            
            NSUserDefaults *iconView = [NSUserDefaults standardUserDefaults];
            [iconView setObject:snsAccount.iconURL forKey:@"iconURL"];
            
            if (![iconName objectForKey:@"username"]) {
                _nameLabel.text = @"登录";
                _imageView.image = [UIImage imageNamed:@"head@2x.png"];
            }else{
            
                _nameLabel.text = [iconName objectForKey:@"username"];
                [_imageView sd_setImageWithURL:[NSURL URLWithString:[iconView objectForKey:@"iconURL"]]];
            }
            
        }});

}



-(void)showContent:(NSString*)content{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alterView show];
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
