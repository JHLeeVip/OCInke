//
//  JHHotViewController.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/25.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHHotViewController.h"
#import "JHLiveHandler.h"
#import "JHHotLiveCell.h"

@interface JHHotViewController ()

/** 模型数组 */
@property(nonatomic,strong) NSArray *dataArr;

@end

@implementation JHHotViewController
static NSString * cellID = @"JHHotLiveCell";

//- (NSArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [[NSArray alloc] init];
//    }
//    return _dataArr;
//}


#pragma mark =====================================
#pragma mark -控制器构造相关
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
- (void)initUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"JHHotLiveCell" bundle:nil] forCellReuseIdentifier:cellID];
    //只执行一次,相对于代理方法更加高效
    self.tableView.rowHeight = SCREEN_WIDTH + 8 + 50 + 8 + 8;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)loadData{
    JHweakSelf;
    [JHLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        weakSelf.dataArr = obj;
        [weakSelf.tableView reloadData];
    } failed:^(id obj) {
        JHLog(@"%@",obj);
    }];
}


#pragma mark =====================================
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

#pragma mark =====================================
#pragma mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHHotLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.live = self.dataArr[indexPath.row];
        
    return cell;
}


@end
