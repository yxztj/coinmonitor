//
//  ViewController.m
//  testprice
//
//  Created by Jason on 14-1-12.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "RootCoinViewController.h"
#import "MJRefreshHeaderView.h"
#import "MonitorPriceItem.h"
#import "PriceDataSet.h"
#import "AddCoinViewController.h"
#import "CoinTableCell.h"
#import "NetWorker.h"
#import "TableDataDelegate.h"
#import "PickerDataDelegate.h"
#import "TWStatus.h"
#import "ProgressHUD/ProgressHUD.h"

NSString *const MJTableViewCellIdentifier = @"Cell";

@interface RootCoinViewController ()
{
    NSMutableArray *_fakeData;
    MJRefreshHeaderView *_header;
    NSCondition *condition;
    NSThread *worker;
}
@end

@implementation RootCoinViewController

- (IBAction)toggleMove:(id)sender {
    [self.myTable setEditing:!self.myTable.editing animated:YES];
    if (self.myTable.editing==YES) {
        [self.btnEdit setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"maintoadd"]) {
        UINavigationController* navigation= segue.destinationViewController;
        AddCoinViewController *ac = (AddCoinViewController *)segue.destinationViewController;
        ac.tabledataDelegate=self.tabledataDelegate;
        ac.mainView = self;
        //set the properties...
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 1.注册
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
    
    // 2.初始化假数据
    _fakeData = [NSMutableArray array];
    /*
    for (int i = 0; i<12; i++) {
        int random = arc4random_uniform(1000000);
        [_fakeData addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
     */
    self.dataset=[[PriceDataSet alloc] init];
    self.tabledataDelegate=[[TableDataDelegate alloc] init];
    
    
    //Init components
    condition=[[NSCondition alloc] init];
    self.nworker=[[NetWorker alloc] init];
    
    self.nworker.dataset=self.dataset;
    self.nworker.rootCoinViewController=self;
    
    self.tabledataDelegate.dataset=self.dataset;
    self.tabledataDelegate.rootController=self;
    self.tabledataDelegate.myTableView=self.myTable;
    //self.tableView.dataSource=self.tabledataDelegate;
    //self.tableView.delegate=self.tabledataDelegate;
    
    //self.myTable = [[HVTableView alloc] initWithFrame:CGRectMake(0, (self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height), 320, 320) expandOnlyOneCell:NO enableAutoScroll:YES];
    self.myTable.dataSource = self.tabledataDelegate;;
    self.myTable.delegate = self.tabledataDelegate;;
    [self.myTable reloadData];
    //[self.view addSubview:self.myTable];
    
    //Start pumping
    [self.nworker StartPumping];
    
    [self addHeader];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self refreshData:nil];

}

- (void) refreshData:(NSNotification *)notification
{
    [self.nworker.hasJobToDo lock];
    self.nworker.updateMain=YES;
    [self.nworker.hasJobToDo signal];
    [self.nworker.hasJobToDo unlock];
    [TWStatus showLoadingWithStatus:@"自动刷新中"];
    
    //[[SvStatusBarTipsWindow shareTipsWindow] showTips:@"正在刷新"];
    //[ProgressHUD show:@"正在刷新"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateDetail:(NSString*)marketname Coinname:(NSString*)coinname
{
    
    self.nworker.strDetailCoin=coinname;
    self.nworker.strDetailMarket=marketname;
    
    [self.nworker.hasJobToDo lock];
    self.nworker.updateDetail=YES;
    [self.nworker.hasJobToDo signal];
    [self.nworker.hasJobToDo unlock];
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.myTable;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        
        [self.nworker.hasJobToDo lock];
        self.nworker.updateMain=YES;
        [self.nworker.hasJobToDo signal];
        [self.nworker.hasJobToDo unlock];

        //[self performSelectorInBackground:@selector(doneWithView) withObject:nil];
        
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block

    };
    //[header beginRefreshing];
    _header = header;
}

- (void)doneWithView
{
    //Check if worker has done its job.
//    [self.nworker.workDone lock];
//    [self.nworker.workDone wait];
//    [self.nworker.workDone unlock];
    // 刷新表格
    [self.myTable reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//    [_header performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    [_header endRefreshing];
}


-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
	
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	
	// 返回新的改变大小后的图片
	return scaledImage;
}

@end
