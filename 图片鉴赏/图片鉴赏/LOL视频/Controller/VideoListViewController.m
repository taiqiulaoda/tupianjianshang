//
//  VideoListViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "VideoListViewController.h"
#import "SecondModel.h"
#import "SecondCell.h"
#import "ViedoPlayController.h"

@interface VideoListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray * dataArray;
    int _page;
    SecondModel *model;
}


@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 0;
    [self _loadData];
    
    [self _creatTableView];
    
    
    
    
}


- (void)loadNewData
{
    _page = 0;
    
    [self _loadData];
    
}

- (void)loadMoreData
{
    _page++;
    
    [self _loadData];
}



//数据读取
-(void)_loadData{

    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD showWithOverlay];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=0&jb=0&limit=50&nc=0&offset=%d&tk=0",self.author,_page];

    AFHTTPRequestOperationManager *mangaer = [AFHTTPRequestOperationManager manager];
    mangaer.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mangaer GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dic);
        NSMutableArray *data = [[NSMutableArray alloc]init];
        NSArray * array = dic[@"videos"];
        for (NSDictionary *mydic in array) {
            model = [[SecondModel alloc]initWithDataDic:mydic];
            model.myid = mydic[@"id"];
            model.time = mydic[@"time"];
            model.thumb = mydic[@"thumb"];
            model.title = mydic[@"title"];
            model.author = mydic[@"author"];
            model.date = mydic[@"date"];
            [data addObject:model];
        }
        
        
        if (_page == 0)
        {
            dataArray = data;
        }
        else
        {
            [dataArray addObjectsFromArray:data];
            
        }
        
        
        [tableview reloadData];
        
        [tableview.header endRefreshing];
        [tableview.footer endRefreshing];
        
        [GiFHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}


-(void)_creatTableView{
    tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    //上下刷新加载数据
    tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    [self.view addSubview:tableview];

}


//协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     SecondCell*cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SecondCell" owner:self options:nil]lastObject];
    }
    model = dataArray[indexPath.row];
    cell.secondmodel = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ViedoPlayController *player = [[ViedoPlayController alloc]init];
    
    model = dataArray[indexPath.row];
    player.Secmodel = model;
    
    
    [self.navigationController pushViewController:player animated:YES];

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
