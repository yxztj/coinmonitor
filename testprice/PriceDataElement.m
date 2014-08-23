//
//  PriceDataElement.m
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "PriceDataElement.h"


@implementation PriceDataElement

-(id) init
{
    if(self=[super init])
    {
        self.lstBuy=[[NSMutableArray alloc] init];
        self.lstSell=[[NSMutableArray alloc] init];
    }
    return self;
}

@end
