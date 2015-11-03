//
//  GirlViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "GirlViewController.h"
#import "GirlModel.h"
#import "GirlCell.h"

@interface GirlViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSString *_timeString;
    int _page;
    int _time;

}
@end

@implementation GirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"美女欣赏";
    
    _page = 0;
    

    //获取时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    _timeString = [NSString stringWithFormat:@"%f",a];
    _time = [_timeString intValue];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    
    self.navigationController.hidesBarsOnSwipe = YES;
    [self loadData];
    
    [self creatView];
}


-(void)creatView{
    tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor blackColor];
    
    tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    
    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.view addSubview:tableview];

}
-(void)loadNew{
    _page = 0;
    
    _time = _timeString.intValue;
    
    [self loadData];
    

}
-(void)loadMore{
    _page ++;
    
    _time = _timeString.intValue - 3600*(_page*24);
    
    [self loadData];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GirlCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GirlCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    GirlModel *model = dataArray[indexPath.row];
    cell.girlmodel = model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 320;
}


//数据加载
-(void)loadData{
    
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD showWithOverlay];

    NSString *urlString = [NSString stringWithFormat:@"http://223.6.252.214/weibofun/weibo_list.php?apiver=100&category=weibo_girls&page=%d&page_size=15&max_timestamp=%d&vip=1&platform=0&appver=0&udid=0",_page,_time];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dict);
        NSMutableArray *data = [[NSMutableArray alloc]init];
        NSArray * array = dict[@"items"];
        for (NSDictionary *dic in array) {
            GirlModel *model = [[GirlModel alloc]initWithDataDic:dic];
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
        NSLog(@"请求美女失败了");
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
