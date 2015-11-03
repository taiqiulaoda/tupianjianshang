//
//  BaseViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];

}
-(void)setNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_more_normal@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
}
//右键
-(void)rightAction:(UIButton*)button{
    MMDrawerController *mm = self.mm_drawerController;
    [mm openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    
}

-(void)leftAction:(UIButton*)button{
    MMDrawerController *mm = self.mm_drawerController;
    [mm openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
