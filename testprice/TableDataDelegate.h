//
//  TableDataDelegate.h
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceDataSet.h"
#import "HVTableView.h"
#import "RootCoinViewController.h"

#define CELLHEIGHTFOLDED 68
#define CELLHEIGHTEXPANDED 140

@interface TableDataDelegate : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (readwrite,retain) PriceDataSet *dataset;
@property (nonatomic) NSMutableArray *cellDataArray;
@property  NSMutableDictionary *selectedIndexes;
@property UITableView* myTableView;

@property RootCoinViewController* rootController;
@property int selectedRow;
@property NSDictionary* dictionary;
-(void)deselectCell;

@end
