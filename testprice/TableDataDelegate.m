//
//  TableDataDelegate.m
//  testprice
//
//  Created by Jason on 14-1-16.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "TableDataDelegate.h"
#import "MonitorPriceItem.h"
#import "CoinTableCell.h"
#import "MarketDetailView.h"



#define LBLCOIN_TAG 1
#define LBLMARKET_TAG 2
#define LBLPRICE_TAG 3
#define LBLTIME_TAG 4
#define LBLHIGH_TAG 5
#define LBLLOW_TAG 6
#define LBLVOL_TAG 7
#define IMGCOIN_TAG 8
#define IMGGLYPH_TAG 9

@implementation TableDataDelegate


-(id) init
{
    if(self=[super init])
    {
        self.cellDataArray=[[NSMutableArray alloc] init];
//        [self.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:@"OKCoin" coinname:@"BTC" viewindex:0]];
//        [self.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:@"OKCoin" coinname:@"LTC" viewindex:1]];
//        [self.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:@"BTC38" coinname:@"PPC" viewindex:2]];
//        [self.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:@"BTC38" coinname:@"PTS" viewindex:3]];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"monitor_list" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        self.dictionary = dic;
        
        NSArray *root = [self.dictionary allKeys];
        //NSArray *root = [rootArray sortedArrayUsingSelector:@selector(compare:)];
        //self.fatherArray = root;
        
        //NSString *fatherSec = [self.fatherArray objectAtIndex:0];
        
        //self.childerArray = array;
        
        for (int i=0; i<root.count; i++) {
            NSString* marketname = [root objectAtIndex:i];
            NSArray *array = [self.dictionary objectForKey:marketname];
            for (int j=0; j<array.count; j++) {
                NSString* coinname= [array objectAtIndex:j];
                [self.cellDataArray addObject:[[MonitorPriceItem alloc]initWithParams:marketname coinname:coinname]];
            }
            
        }
        self.selectedIndexes = [[NSMutableDictionary alloc] init];
        
        
        
        
    }
    return self;
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [self.selectedIndexes objectForKey:[NSNumber numberWithInt:indexPath.row]];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	// Deselect cell
//	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
//	UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//	// Toggle 'selected' state
//	BOOL isSelected = ![self cellIsSelected:indexPath];
//    self.selectedRow=indexPath.row;
//    //NSLog(@"Row %d is selected", indexPath.row);
//	
//    if (isSelected) {
//        
//
////        UIView* upper=()tableView.superview
////        
////        [self.upperShadeView setFrame:CGRectMake(0, 0, 320, cell.frame.origin.y)];
////        self.upperShadeView.alpha=0;
//        
//        
//        
//        [UIView animateWithDuration:.3 animations:^{
//            
//            [cell.contentView viewWithTag:IMGGLYPH_TAG].transform = CGAffineTransformMakeRotation(1.57);
//        }];
//    }
//    else
//    {
//        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//
//        [UIView animateWithDuration:.3 animations:^{
//            
//            [cell.contentView viewWithTag:IMGGLYPH_TAG].transform = CGAffineTransformMakeRotation(0);
//        }completion:^(BOOL finished) {
//            NSLog(@"%f", cell.frame.origin.y);
//        }];
//    }
//    
//	// Store cell 'selected' state keyed on indexPath
//	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
//	[self.selectedIndexes setObject:selectedIndex forKey:[NSNumber numberWithInt:indexPath.row]];
//    
//	// This is where magic happens...
//	[tableView beginUpdates];
//	[tableView endUpdates];
//    
//    if (isSelected) {
//        [self.rootController shadeOtherCells:cell.frame];
//    }
//    else
//    {
//        [self.rootController removeShade];
//    }
//    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CoinCell";
    
    UILabel *lblCoin, *lblMarket, *lblPrice, *lblTime, *lblHigh, *lblLow, *lblVol;
    UIImageView *imgCoin;
    //MarketDetailView* marketDetailView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [cell.contentView viewWithTag:IMGGLYPH_TAG].transform = CGAffineTransformMakeRotation(0);
        
    }
    
    
    
        lblCoin = (UILabel *)[cell.contentView viewWithTag:LBLCOIN_TAG];
        lblMarket = (UILabel *)[cell.contentView viewWithTag:LBLMARKET_TAG];
        lblPrice = (UILabel *)[cell.contentView viewWithTag:LBLPRICE_TAG];
        lblTime = (UILabel *)[cell.contentView viewWithTag:LBLTIME_TAG];
        lblHigh = (UILabel *)[cell.contentView viewWithTag:LBLHIGH_TAG];
        lblLow = (UILabel *)[cell.contentView viewWithTag:LBLLOW_TAG];
        lblVol = (UILabel *)[cell.contentView viewWithTag:LBLVOL_TAG];
        
        imgCoin = (UIImageView *)[cell.contentView viewWithTag:IMGCOIN_TAG];
        
//        secondLabel = (UILabel *)[cell.contentView viewWithTag:SECONDLABEL_TAG];
//        photo = (UIImageView *)[cell.contentView viewWithTag:PHOTO_TAG];
//        marketDetailView = (MarketDetailView*)[cell.contentView viewWithTag:DETAILVIEW_TAG];
    
    
//    if (indexPath.row %2 ==1)
//		cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
//	else
//		cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    
    //NSDate *now = [[NSDate alloc] init];
    
    //Get a monitor item
    MonitorPriceItem *item=[self.cellDataArray objectAtIndex:indexPath.row];
    NSString* coinname=item.coinName;
    NSString* marketname=item.marketName;
    float price=[self.dataset getCurrentCoinPrice:marketname coinname:coinname];
    NSString* timeString = [dateFormat stringFromDate:[self.dataset getCoinUpdateTime:marketname coinname:coinname]];
    if(timeString==nil) timeString=@"无";
    
    PriceDataElement *element=[self.dataset getCoinElementFromMarket:marketname coinname:coinname];
    
    //Set the cell content
    lblCoin.text=coinname;
    lblPrice.text = [coinname isEqualToString:@"BTSX"] ? [NSString stringWithFormat:@"￥%0.4f", price] : [NSString stringWithFormat:@"￥%0.2f", price];
    lblTime.text = [NSString stringWithFormat:@"%@", timeString];
    lblMarket.text = marketname;
    if (![marketname isEqualToString:@"BTC38"]) {
        lblHigh.text = [NSString stringWithFormat:@"%0.2f", element.highest];
        lblLow.text = [NSString stringWithFormat:@"%0.2f", element.lowest];
        lblVol.text = [NSString stringWithFormat:@"%0.2f", element.volume];
    }
    
    
    imgCoin.image = [UIImage imageNamed:[PriceDataSet getImageName:coinname]];

    
    
    return cell;

}

-(void)deselectCell
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.selectedRow inSection:0];
    [self tableView:self.myTableView didSelectRowAtIndexPath:index];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *) fromIndexPath
     toIndexPath:(NSIndexPath *)toIndexPath{
    id object=[self.cellDataArray objectAtIndex:[fromIndexPath row]];
    [self.cellDataArray removeObjectAtIndex:[fromIndexPath row]];
    [self.cellDataArray insertObject:object atIndex:[toIndexPath row]];
    //[object release];
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        
        [self.cellDataArray removeObjectAtIndex:[indexPath row]];
        
        // Delete row using the cool literal version of [NSArray arrayWithObject:indexPath]
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//you can define different heights for each cell. (then you probably have to calculate the height or e.g. read pre-calculated heights from an array
	if([self cellIsSelected:indexPath]) {
        NSLog(@"%d is selected",indexPath.row);
		return CELLHEIGHTEXPANDED;
	}
	NSLog(@"%d is not selected",indexPath.row);
	return CELLHEIGHTFOLDED;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}

-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(size);
	
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	
	// 返回新的改变大小后的图片
	return scaledImage;
}

@end
