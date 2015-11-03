//
//  DuanziViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "DuanziViewController.h"
#import "DuanziModel.h"
#import "DuanziCell.h"

@interface DuanziViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSString *_timeString;
    int _page;
    int _time;

}
@end

@implementation DuanziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadData];
    
    [self creatTableView];
    
    [self creatBackButton];
    
    _page = 0;
    
    //获取当前系统时间戳

    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970];
    
    _timeString = [NSString stringWithFormat:@"%f",a];
    
    NSLog(@"%d",_timeString.intValue);
    
    _time = [_timeString intValue];
    

}

//导航栏返回按钮
-(void)creatBackButton{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    imageView.image = [UIImage imageNamed:@"breaking_news_bkg_red@2x"];

    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20 , 10, 40, 50);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
}


-(void)creatTableView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"12.png"];
    [self.view addSubview:imageView];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.dataSource = self;
    tableview.delegate = self;
    
    
    //上下 加载
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




//返回按钮
-(void)backAction:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DuanziCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[DuanziCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    //cell的透明度
     cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
   //点击选中效果没有
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    DuanziModel *model = dataArray[indexPath.row];
    
    cell.duanzimodel = model;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DuanziModel *model = dataArray[indexPath.row];
    
    
    CGRect contentRect = [model.wbody boundingRectWithSize:CGSizeMake(165, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
    
    double height = 25+contentRect.size.height;
    
    return height<(60)?:height;

}


-(void)loadData{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD showWithOverlay];
    
    //获取当前的时间戳
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",a];
    NSLog(@"%d",timeString.intValue);

    NSString *urlString = [NSString stringWithFormat:@"http://223.6.252.214/weibofun/weibo_list.php?apiver=10500&category=weibo_jokes&page=%d&page_size=15&max_timestamp=%d&vip=1&platform=0&appver=0&udid=0",_page,_time];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",dic);
        NSArray *items = dic[@"items"];
        NSMutableArray *data = [[NSMutableArray alloc]init];
        for (NSDictionary *mydic in items) {
            DuanziModel *model = [[DuanziModel alloc]initWithDataDic:mydic];
            [data  addObject:model];
        }
        
        if (_page == 0) {
            dataArray = data;
        }else{
            [dataArray addObjectsFromArray:data];
        }
        
        [tableview.header endRefreshing];
        [tableview.footer endRefreshing];
        
        [GiFHUD dismiss];
        [tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
