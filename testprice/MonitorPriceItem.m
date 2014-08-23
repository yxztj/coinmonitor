//
//  MonitorPriceItem.m
//  testprice
//
//  Created by Jason on 14-1-15.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "MonitorPriceItem.h"

@implementation MonitorPriceItem

-(id) initWithParams:(NSString*)marketname coinname:(NSString*)coinname
{
    if(self=[super init])
    {
        self.marketName=marketname;
        self.coinName=coinname;
    }
    return self;
}

@end
