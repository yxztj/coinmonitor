//
//  AddCoinViewController.m
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "AddCoinViewController.h"
#import "MonitorPriceItem.h"
#import "PickerDataDelegate.h"

@interface AddCoinViewController ()



@end



@implementation AddCoinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)addCoin:(id)sender {
    
    //market = self.pickerdataDelegate.selectedMarket;
    NSString* market=[self.pickerdataDelegate.fatherArray objectAtIndex:[self.pckCoin selectedRowInComponent:0]];
    NSString* coin=[self.pickerdataDelegate.childerArray objectAtIndex:[self.pckCoin selectedRowInComponent:1]];
    //NSString *coin = self.pickerdataDelegate.selectedCoin;
    
    
    [self.tabledataDelegate.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:market coinname:coin]];
    
    [self.mainView.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pickerdataDelegate=[[PickerDataDelegate alloc] init];
    self.pckCoin.dataSource=self.pickerdataDelegate;
    self.pckCoin.delegate=self.pickerdataDelegate;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
