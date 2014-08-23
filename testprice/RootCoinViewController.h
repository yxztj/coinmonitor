//
//  ViewController.h
//  testprice
//
//  Created by Jason on 14-1-12.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorker.h"
#import "PriceDataSet.h"

#import "HVTableView.h"




@class NetWorker;
@class TableDataDelegate;
@class PickerDataDelegate;


@interface RootCoinViewController : UIViewController
- (IBAction)haha:(id)sender;
- (void)workerproc;
- (void)doneWithView;
- (void) shadeOtherCells:(CGRect)rect;
- (void) removeShade;
- (void) refreshData;
//@property (weak, nonatomic) IBOutlet UITextField *txtOut;
@property (weak, nonatomic) IBOutlet UITextView *txtOut;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) TableDataDelegate *tabledataDelegate;
@property (nonatomic) PickerDataDelegate *pickerdataDelegate;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
//@property (weak, nonatomic) IBOutlet UIPickerView *pckCoin;
@property (weak, nonatomic) IBOutlet UIPickerView *pckCoin;
@property (weak, nonatomic) IBOutlet UITableView *myTable;

//@property HVTableView* myTable;
@property NSArray* cellTitles;

@property NetWorker *nworker;
@property PriceDataSet *dataset;

@property (retain, nonatomic) UIView *upperShadeView;
@property (retain, nonatomic) UIView *lowerShadeView;


@end
