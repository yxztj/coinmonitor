//
//  PriceDataSet.h
//  testprice
//
//  Created by Jason on 14-1-13.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Markets.h"
#import "PriceDataElement.h"

@interface PriceDataSet : NSObject

@property (readwrite) NSMutableDictionary *dicMarkets;
@property (readwrite) NSMutableArray* monitorSet;


-(void) updateCoinPrice:(NSString*)marketname coinname:(NSString*)coinname price:(NSString*)currentprice;
-(float) getCurrentCoinPrice:(NSString*)marketname coinname:(NSString*)coinname;
-(NSDate*) getCoinUpdateTime:(NSString*)marketname coinname:(NSString*)coinname;
+(NSString*) getImageName:(NSString*)coinname;
-(PriceDataElement*) getCoinElementFromMarket:(NSString*)market coinname:(NSString*)coinname;

@end
