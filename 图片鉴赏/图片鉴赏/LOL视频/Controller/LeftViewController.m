//
//  LeftViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/25.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "DuanziViewController.h"
#import "WallViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _creatButton];
}


-(void)_creatButton{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"breaking_news_bkg_red@2x"];
    [self.view addSubview:imageView];
    
    //开始交互
    imageView.userInteractionEnabled = YES;
    
    //创建侧边栏按钮
    NSArray *itemNames = @[@"返回主页",
                           @"段子",
                           @"壁纸"
                           ];

    for (int i =0; i<itemNames.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(70,i*60+160, 80, 10);
        [btn setTitle:itemNames[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        
    }
    

}

//按钮选择
-(void)selectAction:(UIButton*)button{
    if (button.tag == 0) {
        MMDrawerController *mm = self.mm_drawerController;
        [mm closeDrawerAnimated:YES completion:nil];
    }else if(button.tag == 1){


        DuanziViewController *duanzi = [[DuanziViewController alloc]init];
        
        [self presentViewController:duanzi animated:YES completion:nil];
    }else if(button.tag == 2){

        WallViewController *wall = [[WallViewController alloc]init];
        
        [self presentViewController:wall animated:YES completion:nil];
    }

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
