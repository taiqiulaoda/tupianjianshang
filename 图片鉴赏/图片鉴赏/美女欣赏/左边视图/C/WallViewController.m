//
//  WallViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WallViewController.h"
#import "WallModel.h"
#import "WallCell.h"

@interface WallViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    
    int _page;
}
@end

@implementation WallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    
    [self creatNav];
    
    [self creatTableView];
    
    _page = 1;
    
    
}

-(void)creatNav{
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    imageView.image = [UIImage imageNamed:@"breaking_news_bkg_red@2x"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 10, 40, 50);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:btn];
    
    
}

-(void)backAction:(UIButton*)button{

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)creatTableView{
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.backgroundColor = [UIColor whiteColor];
    
    tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    [self.view addSubview:tableview];
    
   

}


-(void)loadNewData{
    _page = 1;
    
    [self loadData];

}

-(void)loadMoreData{

    _page ++;
    [self loadData];
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[WallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    WallModel *model = dataArray[indexPath.row];
    cell.wallmodel = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WallModel *model = dataArray[indexPath.row];
    return model.size.intValue;
}

-(void)loadData{
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD showWithOverlay];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.ipadown.com/pic/pic.api.php?page=%d&count=6&category=0&orderby=rand&device=iPhone",_page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",dict);
        NSMutableArray *data = [NSMutableArray array];
        for (NSDictionary *dic in dict) {
            WallModel *model = [[WallModel alloc]initWithDataDic:dic];
            [data addObject:model];
            
            
        }
        if (_page == 1) {
            dataArray = data;
        }else{
            [dataArray addObjectsFromArray:data];
        }
        
        [tableview.header endRefreshing];
        [tableview.footer endRefreshing];
        
        [tableview reloadData];
        [GiFHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络错误");
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
