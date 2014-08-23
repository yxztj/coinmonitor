//
//  DetailViewController.m
//  testprice
//
//  Created by Jason on 14-1-20.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "MarketDetailView.h"


@interface MarketDetailView ()

@end

@implementation MarketDetailView

- (id)initWithFrame:(CGRect)frame DataSet:(PriceDataSet*)dataSet Coinname:(NSString*)coinname Marketname:(NSString*)marketname
{
    self = [super initWithFrame:frame];
    if (self) {
        
        PriceDataElement *element=[dataSet getCoinElementFromMarket:marketname coinname:coinname];
        
        self.lblHighest = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 30.0)];
        self.lblHighest.font = [UIFont systemFontOfSize:15.0];
        self.lblHighest.text=@"最高价";
        [self addSubview:self.lblHighest];
        
        self.lblHighestValue = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 40.0, 100.0, 30.0)];
        self.lblHighestValue.font = [UIFont systemFontOfSize:15.0];
        self.lblHighestValue.text=[NSString stringWithFormat:@"%.2f",element.highest];
        [self addSubview:self.lblHighestValue];
        
        self.lblLowest = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 10.0, 100.0, 30.0)];
        self.lblLowest.font = [UIFont systemFontOfSize:15.0];
        self.lblLowest.text=@"最低价";
        [self addSubview:self.lblLowest];
        
        self.lblLowestValue = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 40.0, 100.0, 30.0)];
        self.lblLowestValue.font = [UIFont systemFontOfSize:15.0];
        self.lblLowestValue.text=[NSString stringWithFormat:@"%.2f",element.lowest];
        [self addSubview:self.lblLowestValue];
        
        self.lblVolume = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 10.0, 100.0, 30.0)];
        self.lblVolume.font = [UIFont systemFontOfSize:15.0];
        self.lblVolume.text=@"成交量";
        [self addSubview:self.lblVolume];
        
        self.lblVolumeValue = [[UILabel alloc] initWithFrame:CGRectMake(230.0, 40.0, 100.0, 30.0)];
        self.lblVolumeValue.font = [UIFont systemFontOfSize:15.0];
        self.lblVolumeValue.text=[NSString stringWithFormat:@"%.2f",element.volume];
        [self addSubview:self.lblVolumeValue];
        
//        self.tblBuy = [[UITableView alloc] initWithFrame:CGRectMake(0,70,150,220)];
//        [self addSubview:self.tblBuy];
//        
//        self.tblSell = [[UITableView alloc] initWithFrame:CGRectMake(170,70,150,220)];
//        [self addSubview:self.tblSell];

    }
    return self;
}



//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
