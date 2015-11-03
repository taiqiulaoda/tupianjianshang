//
//  MainTabBarController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self _creatViewController];

 
    
}


-(void)_creatViewController{


    NSArray *storys = @[@"Video",@"Picture",@"Movie",@"Girl"];
    NSMutableArray * viewArray = [[NSMutableArray alloc]initWithCapacity:4];
    for (int i = 0; i < 4 ; i++) {
        UIStoryboard * story = [UIStoryboard storyboardWithName:storys[i] bundle:nil];

        BaseNavViewController *nav = [story instantiateInitialViewController];
        


        [viewArray addObject:nav];
    }

    self.viewControllers = viewArray;
    
    //创建按钮图片
    NSArray *pictures = @[@"tabbar_video@2x",
                          @"tabbar_news@2x",
                          @"tabbar_picture@2x",
                          @"tabbar_setting@2x"];
    NSArray *hlpictures = @[@"tabbar_video_hl@2x",
                            @"tabbar_news_hl@2x",
                            @"tabbar_picture_hl@2x",
                            @"tabbar_setting_hl@2x"];
    NSArray *titles = @[@"LOL视频",@"内涵图片",@"内涵视频",@"美女欣赏"];
    
    UITabBar *tabbar = self.tabBar;
    
    for (int i = 0; i <4; i++) {
        
        UITabBarItem *tabbarItem = [tabbar.items objectAtIndex:i];
        
        tabbarItem.title = titles[i];
        
        tabbarItem.image = [UIImage imageNamed:pictures[i]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
        
        tabbarItem.selectedImage = [[UIImage imageNamed:hlpictures[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
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
