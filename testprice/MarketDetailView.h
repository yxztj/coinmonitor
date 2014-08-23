//
//  DetailViewController.h
//  testprice
//
//  Created by Jason on 14-1-20.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceDataSet.h"

@interface MarketDetailView : UIView

@property UILabel* lblHighest;
@property UILabel* lblHighestValue;
@property UILabel* lblLowest;
@property UILabel* lblLowestValue;
@property UILabel* lblVolume;
@property UILabel* lblVolumeValue;

@property UITableView* tblBuy;
@property UITableView* tblSell;

- (id)initWithFrame:(CGRect)frame DataSet:(PriceDataSet*)dataSet Coinname:(NSString*)coinname Marketname:(NSString*)marketname;

@end
