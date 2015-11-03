//
//  VideoViewController.m
//  图片鉴赏
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoListViewController.h"
#import "FirstModel.h"
#import "FirstCell.h"

@interface VideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * imageCollection;
    NSMutableArray * dataArray;
    FirstModel *model;

    
}
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"LOL视频";

    [self creatCollection];
    [self loadData];

    
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];


    //注册单元格
    [imageCollection  registerClass:[FirstCell class] forCellWithReuseIdentifier:@"videoCell"];
    
}

-(void)creatCollection{
    UICollectionViewFlowLayout *collection = [[UICollectionViewFlowLayout alloc]init];
    
    collection.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat itemWidth = (kScreenWidth - 10*4)/3;
    collection.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    imageCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:collection];
    imageCollection.delegate = self;
    imageCollection.dataSource = self;
    imageCollection.backgroundColor = [UIColor whiteColor];
    

    
    
    [self.view addSubview:imageCollection];

}





//读取数据
-(void)loadData{

    
    NSString *urlString = @"http://api.dotaly.com/lol/api/v1/authors?iap=0&ident=0&jb=0&nc=0&tk=0";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dict);
        dataArray = [[NSMutableArray alloc]init];
        NSArray *datas = dict[@"authors"];
        for (NSDictionary *dic in datas) {
            model = [[FirstModel alloc]initWithDataDic:dic];
            model.name = dic[@"name"];
            model.pop = dic[@"pop"];
            model.url = dic[@"url"];
            model.icon = dic[@"icon"];
            model.detail = dic[@"detail"];
            model.youku_id = dic[@"youku_id"];
            model.wxid = dic[@"id"];
            
            [dataArray addObject:model];
        }
        
       // NSLog(@"%@",datas);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //数据刷新
            [imageCollection reloadData];
        });
      
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
}




//协议
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;

}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];

    
    model = dataArray[indexPath.row];
    //创建一个图片背景
    UIImageView *imageView = [[UIImageView alloc]init];
    cell.backgroundView = imageView;


    cell.titleLabel.text = model.name;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"Icon-40@3x"]];
    
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    

    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:cell.titleLabel];
    return cell;
}

//选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    VideoListViewController *list = [[VideoListViewController alloc]init];
    
    
    //隐藏tabbar
    list.hidesBottomBarWhenPushed = YES;
    
    
    //选中单元格传递给下一个控制器
    model = dataArray[indexPath.row];
    list.author = model.wxid;
    
    [self.navigationController pushViewController:list animated:YES];
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
