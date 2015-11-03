//
//  AppDelegate.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMDrawerController.h"
#import "VideoViewController.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    //初始化友盟
    [UMSocialData setAppKey:@"551a5860fd98c513b60002f7"];

    //判断第一次
    if (![self firstView]) {
        [self secondview];
    }
    

    return YES;
}

-(BOOL)firstView{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFist"]) {
        UIScrollView * scrollview = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        scrollview.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeight);
        
        scrollview.pagingEnabled = YES;
        
        scrollview.showsHorizontalScrollIndicator = NO;
        
        NSArray *pageImage = @[@"1",@"2",@"3"];
        
        for (int i = 0; i<3; i++) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            imageview.image = [UIImage imageNamed:pageImage[i]];
            
            imageview.frame = CGRectMake(kScreenWidth *i, 0 , kScreenWidth, kScreenHeight);
            
            [scrollview addSubview:imageview];
            
            if (i == 2) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
                imageview.userInteractionEnabled = YES;
                [imageview addGestureRecognizer:tap];
            }
        }
        [self.window addSubview:scrollview];
        return NO;
    }
    
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"isFist"];
    return YES;
}



- (void)secondview{
    
    //容积控制器
    LeftViewController *left = [[LeftViewController alloc]init];
    RightViewController *right = [[RightViewController alloc]init];
    MainTabBarController * main = [[MainTabBarController alloc]init];
    
    MMDrawerController *mm = [[MMDrawerController alloc]initWithCenterViewController:main leftDrawerViewController:left rightDrawerViewController:right];
    
    //左右打开宽度
    [mm setMaximumLeftDrawerWidth:240.0];
    [mm setMaximumRightDrawerWidth:kScreenWidth];
    
    //设置手势有效区域
    [mm setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mm setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager]setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    [[MMExampleDrawerVisualStateManager sharedManager]setRightDrawerAnimationType:MMDrawerAnimationTypeParallax];
    
    //block
    [mm setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    
    
    self.window.rootViewController = mm;
    
        //添加启动界面图
        UIImageView *startView = [[UIImageView alloc]initWithFrame:self.window.bounds];
        startView.image = [UIImage imageNamed:@"280208.jpg"];
    
        [mm.view addSubview:startView];
    
        [UIView animateWithDuration:0 animations:^{
            startView.alpha = 1;
        }];
        [UIView animateWithDuration:3 animations:^{
            startView.alpha = 0;
        }];
        //延迟消失
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            startView.alpha = 0;
        } completion:nil];
    

}

-(void)imageTap:(UITapGestureRecognizer*)button{
  
    [self secondview];
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
