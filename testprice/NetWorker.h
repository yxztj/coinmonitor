//
//  NetWorker.h
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceDataSet.h"
#import "RootCoinViewController.h"

@class RootCoinViewController;

@interface NetWorker : NSObject

@property NSThread *worker;
@property PriceDataSet *dataset;
@property NSCondition *hasJobToDo;
@property NSCondition *workDone;
@property RootCoinViewController *rootCoinViewController;
@property BOOL updateMain;
@property BOOL updateDetail;
@property NSString *strDetailMarket;
@property NSString *strDetailCoin;

-(void) WorkerProc;
-(void) StartPumping;
-(void)UpdateOKCoinBTCDetail;

@end
