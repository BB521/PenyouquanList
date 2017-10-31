//
//  ViewController.m
//  朋友圈高性能
//
//  Created by Binbin Mu on 2017/10/27.
//  Copyright © 2017年 Binbin Mu. All rights reserved.
//

#import "ViewController.h"
#import <YYLabel.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "PenyouquanCell.h"
#import "PenyouquanModal.h"
#import "YYFPSLabel.h"
#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation ViewController

#pragma mark - Getter

- (NSMutableArray *)dataSource
{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[PenyouquanCell class] forCellReuseIdentifier:@"PenyouquanCell"];
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    

    _fpsLabel = [YYFPSLabel new];
   
    _fpsLabel.frame = CGRectMake(20, 20, 0, 0);
    
     [_fpsLabel sizeToFit];
    
    _fpsLabel.alpha = 1;
    [self.view addSubview:_fpsLabel];

    
    NSArray *imageArray = @[@"https://img.chuizhicai.com/product/20170525/dfa33deb-a228-4a96-bc14-879079497995.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170421/e91186ef-2e9a-4118-8fb9-ddc887a6c6fc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/ad/20170927/d16b8eb5-f0a2-419d-bde7-8afedc14fa73.jpg",@"https://img.chuizhicai.com/product/20170616/6f989f6e-15bc-4a5f-9c0d-548f265e24bc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170704/93a18f6c-bef0-45e7-a22d-7fbe4605e07a.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400"];
    
    
    for (int i = 0; i < 60; i++) {
        
        PenyouquanModal *modal = [[PenyouquanModal alloc]init];
        modal.iconImage = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        modal.iconName = @"朋友圈啊";
        
        int number = arc4random_uniform(9);

        
        NSMutableArray *imagesArray = [NSMutableArray array];
        
        NSString *string = [NSString string];
        
        for (int i = 0; i < number; i++) {
            
            int pictureCount = (int)imageArray.count;
            
            int picture = arc4random_uniform(pictureCount);
            
           NSString * string2  = @"斗鱼,主要是指归属于鲈形目、攀鲈亚目、丝足鲈科、斗鱼亚科的小型鱼类,与其他鱼类相似,主要以鳃呼吸";
            string = [string stringByAppendingString:string2];
            [imagesArray addObject:imageArray[picture]];
        }
        
        modal.TitleName = string;
        
        modal.images = imagesArray;
        
        [self.dataSource addObject:modal];
    }
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.dataSource.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PenyouquanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PenyouquanCell" forIndexPath:indexPath];

    cell.modal = self.dataSource[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

   return [tableView fd_heightForCellWithIdentifier:@"PenyouquanCell" cacheByIndexPath:indexPath configuration:^(PenyouquanCell * cell) {
      
       cell.modal = self.dataSource[indexPath.row];
       
   }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
