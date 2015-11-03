//
//  PictureViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureModel.h"
#import "PictureCell.h"

@interface PictureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSString *_timeString;
    int _page;
    int _time;
}
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内涵图片";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    _page = 0;
    

    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    _time = [_timeString intValue];

    
    [self loadData];
    
    [self creatView];
    
    
}

-(void)creatView{
    
    tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    tableview.dataSource = self;
    tableview.delegate = self;
    
    
    tableview.backgroundColor = [UIColor blackColor];
    
    //上滑隐藏 下滑出现
    self.navigationController.hidesBarsOnSwipe = YES;
    
    //隐藏表格线
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsData)];
    
    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    [self.view addSubview:tableview];


}

-(void)loadNewsData{
    _page = 0;
    
    _time = _timeString.intValue;
    
    [self loadData];

}

-(void)loadMoreData{

    _page ++;
    
    _time = _timeString.intValue - 3600*(_page*24);
    
    [self loadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureCell *cell = [tableview dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    PictureModel *model = dataArray[indexPath.row];
    cell.picturemodel = model;
    cell.middleImage.frame = CGRectMake(0, 0, kScreenWidth, model.wpic_m_height.intValue);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    PictureModel *model = dataArray[indexPath.row];
    
    return model.wpic_m_height.intValue;
}


-(void)loadData{

    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD showWithOverlay];
    //获取时间戳
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];
    NSLog(@"%d",timeString.intValue);
    
    NSString *urlString = [NSString stringWithFormat:@"http://223.6.252.214/weibofun/weibo_list.php?apiver=10500&category=weibo_pics&page=%d&page_size=15&max_timestamp=%d&vip=1&platform=0&appver=0&udid=0",_page,_time];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dict);
        NSMutableArray *data = [NSMutableArray array];
        NSArray *array = dict[@"items"];
        for (NSDictionary *dic in array) {
            PictureModel *model = [[PictureModel alloc]initWithDataDic:dic];
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
        NSLog(@"%@",error);
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
