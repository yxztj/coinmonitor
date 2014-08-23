//
//  NetWorker.m
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "NetWorker.h"
#import "ProgressHUD.h"
#import "PriceDataElement.h"
#import "PriceDataSet.h"

@implementation NetWorker

-(id) init
{
    if(self=[super init])
    {
        self.worker=[[NSThread alloc] initWithTarget:self
                                            selector:@selector(WorkerProc)
                                              object:nil];
        self.hasJobToDo=[[NSCondition alloc]init];
        self.workDone=[[NSCondition alloc] init];
        NSLog(@"NetWorker init.");
    }
    return self;
}

-(void) StartPumping
{
    [self.worker start];
}

-(void) WorkerProc
{
    while(1)
    {
        [self.hasJobToDo lock];
        [self.hasJobToDo wait];
        [self.hasJobToDo unlock];
        
        if (self.updateMain) {
            [self UpdateData];
            self.updateMain=NO;
        }
        else if(self.updateDetail){
            [self UpdateDetail];
        }
        //[NSThread sleepForTimeInterval:5];
        
        //[self performSelectorOnMainThread:@selector(doneWithView) withObject:nil waitUntilDone:NO];
        
        //Notify Mainthread that work is done.
        [self.workDone lock];
        [self.workDone signal];
        [self.workDone unlock];
        
        [self.rootCoinViewController performSelectorOnMainThread:@selector(doneWithView) withObject:nil waitUntilDone:NO];
        
        //Wait for the next work signal.
        
        
        //get data
    }
}

- (void)UpdateDetail
{
    @try {
        //[self UpdateOKCoin];
        if ([self.strDetailMarket isEqualToString:@"OKCoin"] && [self.strDetailCoin isEqualToString:@"BTC"])
        {
            [self UpdateOKCoinBTCDetail];
        }
        
        //[self performSelectorOnMainThread:@selector(PopSuccessMessage) withObject:Nil waitUntilDone:NO];
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"你的网络不给力，重新试试吧！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self performSelectorOnMainThread:@selector(PopErrorMessage) withObject:Nil waitUntilDone:NO];
        
        //[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        
        return;
    }
    @finally {
        
    }
}

- (void)UpdateData
{
    NSLog(@"Networker updating.");
    @try {
        [self UpdateBTCChina];
        [self UpdateOKCoin];
        [self UpdateBTC38];
        [self performSelectorOnMainThread:@selector(PopSuccessMessage) withObject:Nil waitUntilDone:NO];
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"你的网络不给力，重新试试吧！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [self performSelectorOnMainThread:@selector(PopErrorMessage) withObject:Nil waitUntilDone:NO];
        
        //[alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        
        return;
    }
    @finally {
        
    }
    
    
    
}

- (void)PopSuccessMessage
{
    [ProgressHUD showSuccess:@"刷新成功"];
}

- (void)PopErrorMessage
{
    [ProgressHUD showError:@"网络错误"];
}

-(void)UpdateBTCChina
{
    [self UpdateBTCChinaBTC];
    [self UpdateBTCChinaLTC];
    
}

-(void)UpdateOKCoin
{
    [self UpdateOKCoinBTC];
    [self UpdateOKCoinLTC];
    
}

-(void)UpdateOKCoinLTC
{
    
    NSURL *url = [NSURL URLWithString:@"https://www.okcoin.com/api/ticker.do?symbol=ltc_cny"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *dicInfo = [dic objectForKey:@"ticker"];
    
    //NSString *strMessage = [NSString stringWithFormat:@"LTC的价格是 %@  ",[dicInfo objectForKey:@"last"]];
    
    //[dateFormat release];
    //[now release];
    NSString *price =[dicInfo objectForKey:@"last"];
    
    [self.dataset updateCoinPrice:@"OKCoin" coinname:@"LTC" price:price];
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"OKCoin" coinname:@"LTC"];
    element.highest=[[dicInfo objectForKey:@"high"]floatValue];
    element.lowest=[[dicInfo objectForKey:@"low"]floatValue];
    element.volume=[[dicInfo objectForKey:@"vol"]floatValue];
    
    //NSLog(@"Get data from dataset, price is: %f", [self.dataset getCurrentCoinPrice:@"LTC"]);
}


-(void)UpdateOKCoinBTC
{
    //先比特币
    NSURL *url = [NSURL URLWithString:@"https://www.okcoin.com/api/ticker.do"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *dicInfo = [dic objectForKey:@"ticker"];
    
    //NSString *strMessage = [NSString stringWithFormat:@"LTC的价格是 %@  ",[dicInfo objectForKey:@"last"]];
    
    //[dateFormat release];
    //[now release];
    NSString *price =[dicInfo objectForKey:@"last"];
    
    [self.dataset updateCoinPrice:@"OKCoin" coinname:@"BTC" price:price];
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"OKCoin" coinname:@"BTC"];
    element.highest=[[dicInfo objectForKey:@"high"]floatValue];
    element.lowest=[[dicInfo objectForKey:@"low"]floatValue];
    element.volume=[[dicInfo objectForKey:@"vol"]floatValue];
}

-(void)UpdateBTCChinaBTC
{
    //先比特币
    NSURL *url = [NSURL URLWithString:@"https://data.btcchina.com/data/ticker"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *dicInfo = [dic objectForKey:@"ticker"];
    
    //NSString *strMessage = [NSString stringWithFormat:@"LTC的价格是 %@  ",[dicInfo objectForKey:@"last"]];
    
    //[dateFormat release];
    //[now release];
    NSString *price =[dicInfo objectForKey:@"last"];
    
    [self.dataset updateCoinPrice:@"BTCChina" coinname:@"BTC" price:price];
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"BTCChina" coinname:@"BTC"];
    element.highest=[[dicInfo objectForKey:@"high"]floatValue];
    element.lowest=[[dicInfo objectForKey:@"low"]floatValue];
    element.volume=[[dicInfo objectForKey:@"vol"]floatValue];
}

-(void)UpdateBTCChinaLTC
{
    //莱特币
    NSURL *url = [NSURL URLWithString:@"https://data.btcchina.com/data/ticker?market=ltccny"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *dicInfo = [dic objectForKey:@"ticker"];
    
    //NSString *strMessage = [NSString stringWithFormat:@"LTC的价格是 %@  ",[dicInfo objectForKey:@"last"]];
    
    //[dateFormat release];
    //[now release];
    NSString *price =[dicInfo objectForKey:@"last"];
    
    [self.dataset updateCoinPrice:@"BTCChina" coinname:@"LTC" price:price];
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"BTCChina" coinname:@"LTC"];
    element.highest=[[dicInfo objectForKey:@"high"]floatValue];
    element.lowest=[[dicInfo objectForKey:@"low"]floatValue];
    element.volume=[[dicInfo objectForKey:@"vol"]floatValue];
}

-(void)UpdateBTC38
{
    NSURL *url = [NSURL URLWithString:@"http://api.btc38.com/v1/ticker.php?c=all&mk_type=cny"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    //NSDictionary *dicInfo = [dic objectForKey:@"ticker"];
    
    //NSString *strMessage = [NSString stringWithFormat:@"LTC的价格是 %@  ",[dicInfo objectForKey:@"last"]];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
	
    NSDate *now = [[NSDate alloc] init];
    
    NSString* timeString = [dateFormat stringFromDate:now];
    //[dateFormat release];
    //[now release];

    for (NSString *coinname in [dic allKeys]) {
        NSSet *coins = [[NSSet alloc] initWithObjects:
        @"ppc",@"pts",@"btsx",nil];
        
        if ([coins containsObject:coinname]) {
            NSDictionary *ticker = [[dic objectForKey:coinname] objectForKey:@"ticker"];
            [self.dataset updateCoinPrice:@"BTC38" coinname:coinname.uppercaseString price:[ticker objectForKey:@"last"]];
            
            PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"BTC38" coinname:coinname.uppercaseString];
            element.highest = [[ticker objectForKey:@"high"] floatValue];
            element.lowest=[[ticker objectForKey:@"low"] floatValue];
            element.volume=[[ticker objectForKey:@"vol"] floatValue];
            
        }
    }
//    [self.dataset updateCoinPrice:@"BTC38" coinname:@"PPC" price:[[[dic objectForKey:@"ppc"] objectForKey:@"ticker"] objectForKey:@"last"]];
//    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"BTCChina" coinname:@"LTC"];
////    element.highest=[[dic objectForKey:@"high"]floatValue];
////    element.lowest=[[dic objectForKey:@"low"]floatValue];
////    element.volume=[[dic objectForKey:@"vol"]floatValue];
//    
//    [self.dataset updateCoinPrice:@"BTC38" coinname:@"PTS" price:[dic objectForKey:@"pts2cny"]];
//    [self.dataset updateCoinPrice:@"BTC38" coinname:@"BTSX" price:[dic objectForKey:@"btsx2cny"]];
    //[self.dataset updateCoinPrice:@"PTS" price:[dic objectForKey:@"pts2cny"]];
    
    
    //NSLog(@"Get data from dataset, price is: %f", [self.dataset getCurrentCoinPrice:@"LTC"]);
}

-(void)UpdateOKCoinBTCDetail
{
    //先比特币
    NSURL *url = [NSURL URLWithString:@"https://www.okcoin.com/api/depth.do"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSError *error;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"data is :%@",str);
    
    //从返回数据中获取价格信息
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    //NSArray *arrInfo = [dic objectForKey:@"asks"];
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:@"OKCoin" coinname:@"BTC"];
    
    NSArray * arrAsks=[dic objectForKey:@"asks"];
    for (int i=0; i<arrAsks.count; i++) {
        PriceVolumePair pair;
        NSArray *arraypair=[arrAsks objectAtIndex:i];
        pair.Price=[[arraypair objectAtIndex:0] floatValue];
        pair.Volume=[[arraypair objectAtIndex:1] floatValue];
        [element.lstSell addObject:[NSValue value:&pair withObjCType:@encode(PriceVolumePair)]];
        
    }
    
    NSArray * arrBids=[dic objectForKey:@"bids"];
    for (int i=0; i<arrBids.count; i++) {
        PriceVolumePair pair;
        NSArray *arraypair=[arrBids objectAtIndex:i];
        pair.Price=[[arraypair objectAtIndex:0] floatValue];
        pair.Volume=[[arraypair objectAtIndex:1] floatValue];
        [element.lstBuy addObject:[NSValue value:&pair withObjCType:@encode(PriceVolumePair)]];
        
    }
    
//    for (int j=0; j<element.lstBuy.count; j++) {
//        PriceVolumePair p;
//        [[element.lstBuy objectAtIndex:j] getValue:&p];
//        NSLog(@"%.2f,%.2f",p.Price,p.Volume);
//    }
    

}

@end
