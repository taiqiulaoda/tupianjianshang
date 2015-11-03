//
//  MovieViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSString *_timeString;
    int _page;
    int _time;
}
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内涵视频";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self loadData];
    
    [self creatView];
    
    _page = 0;
    
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    NSLog(@"%d",_timeString.intValue);
    _time = [_timeString intValue];
    
    
}

-(void)creatView{

    tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    self.navigationController.hidesBarsOnSwipe = YES;
    

    tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:tableview];

}

-(void)loadNewData{
    _page = 0;
    
    _time = _timeString.intValue;
    
    [self loadData];

}

-(void)loadMoreData{
    
    _page ++;
    
    _time = _timeString.intValue - 3600*(_page*24);
    
    [self loadData];

}



//数据加载
-(void)loadData{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD showWithOverlay];
    
    NSString *urlString = [NSString stringWithFormat:@"http://223.6.252.214/weibofun/weibo_list.php?apiver=10500&category=weibo_videos&page=%d&page_size=15&max_timestamp=%d&vip=1&platform=0&appver=0&udid=0",_page,_time];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dict);
       NSMutableArray *data = [[NSMutableArray alloc]init];
        NSArray *array = dict[@"items"];
        for (NSDictionary *dic in array) {
            MovieModel *model = [[MovieModel alloc]initWithDataDic:dic];
            [data addObject:model];
        }
        if (_page == 0) {
            dataArray = data;
        }else{
            [dataArray addObjectsFromArray:data];
        }
        [tableview.header endRefreshing];
        [tableview.footer endRefreshing];
        
        [tableview reloadData];
        [GiFHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"你的请求出错了,亲");
    }];
}



//协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableview dequeueReusableCellWithIdentifier:@"movieCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieCell" owner:self options:nil]lastObject];
    }
    MovieModel *model = dataArray[indexPath.row];
    cell.moviemodel = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;

}
//视频播放
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = dataArray[indexPath.row];
    NSString *url = model.vplay_url;
    MPMoviePlayerViewController * mp = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:url]];
    [self presentViewController:mp animated:YES completion:nil];

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
