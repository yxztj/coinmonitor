//
//  PriceDataSet.m
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "PriceDataSet.h"
#import "PriceDataElement.h"
#import "MonitorPriceItem.h"

@implementation PriceDataSet

-(id) init
{
    if(self=[super init])
    {
        self.dicMarkets = [[NSMutableDictionary alloc] init];
        
        [self.dicMarkets setObject:[self BTCChinaDicInit] forKey:@"BTCChina"];
        [self.dicMarkets setObject:[self OKCoinDicInit] forKey:@"OKCoin"];
        [self.dicMarkets setObject:[self BTC38DicInit] forKey:@"BTC38"];
        
        
        self.monitorSet = [[NSMutableArray alloc] init];
        
//        [self.monitorSet addObject:[[MonitorPriceItem alloc]initWithParams:@"OKCoin" coinname:@"BTC" ]];
//        [self.monitorSet addObject:[[MonitorPriceItem alloc]initWithParams:@"OKCoin" coinname:@"LTC" ]];
//        [self.monitorSet addObject:[[MonitorPriceItem alloc]initWithParams:@"BTC38" coinname:@"PPC" ]];
//        [self.monitorSet addObject:[[MonitorPriceItem alloc]initWithParams:@"BTC38" coinname:@"PTS"]];
        
        
        
//        PriceDataElement *elementBTC=[[PriceDataElement alloc]init];
//        elementBTC.name=@"BTC";
//        [self.dicMarkets setObject:elementBTC forKey:@"BTC"];
//        
//        PriceDataElement *elementLTC=[[PriceDataElement alloc]init];
//        elementLTC.name=@"LTC";
//        [self.dicMarkets setObject:elementLTC forKey:@"LTC"];
//        
//        PriceDataElement *elementPPC=[[PriceDataElement alloc]init];
//        elementPPC.name=@"PPC";
//        [self.dicMarkets setObject:elementPPC forKey:@"PPC"];
//        
//        PriceDataElement *elementPTS=[[PriceDataElement alloc]init];
//        elementPTS.name=@"PTS";
//        [self.dicMarkets setObject:elementPTS forKey:@"PTS"];
        
    }
    return self;
}

-(NSMutableDictionary*) OKCoinDicInit
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"BTC"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"LTC"];
    
    return dic;
}

-(NSMutableDictionary*) BTC38DicInit
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"BTC"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"LTC"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"PPC"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"PTS"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"BTSX"];
    
    return dic;
}

-(NSMutableDictionary*) BTCChinaDicInit
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"BTC"];
    [dic setObject:[[PriceDataElement alloc] init] forKey:@"LTC"];

    
    return dic;
}

-(void) updateCoinPrice:(NSString*)marketname coinname:(NSString*)coinname price:(NSString*)currentprice
{
    PriceDataElement *element=[self getCoinElementFromMarket:marketname coinname:coinname];
    element.old_Price=element.current_Price;
    element.current_Price=[currentprice  floatValue];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    
    element.updateTime = [[NSDate alloc] init];
    
}

-(PriceDataElement*) getCoinElementFromMarket:(NSString*)market coinname:(NSString*)coinname
{
    NSMutableDictionary *dic=[self.dicMarkets objectForKey:market];
    PriceDataElement *element=[dic objectForKey:coinname];
    return element;
}

-(float) getCurrentCoinPrice:(NSString*)marketname coinname:(NSString*)coinname
{
    PriceDataElement *element=[self getCoinElementFromMarket:marketname coinname:coinname];
    return element.current_Price;
}

-(NSDate*) getCoinUpdateTime:(NSString*)marketname coinname:(NSString*)coinname
{
    PriceDataElement *element=[self getCoinElementFromMarket:marketname coinname:coinname];
    return element.updateTime;
}

+(NSString*) getImageName:(NSString*)coinname
{
    if ([coinname isEqualToString:@"BTC"]) {
        return @"btc.png";
    }
    else if ([coinname isEqualToString:@"LTC"]) {
        return @"ltc.png";
    }
    else if ([coinname isEqualToString:@"PPC"]) {
        return @"ppc.png";
    }
    else if ([coinname isEqualToString:@"PTS"]) {
        return @"pts.png";
    }
    else if ([coinname isEqualToString:@"BTSX"]) {
        return @"bts";
    }
    
    return @"error";
}

@end
