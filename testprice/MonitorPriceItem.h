//
//  MonitorPriceItem.h
//  testprice
//
//  Created by Jason on 14-1-15.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonitorPriceItem : NSObject

@property NSString* marketName;
@property NSString* coinName;

-(id) initWithParams:(NSString*)marketname coinname:(NSString*)coinname;

@end
