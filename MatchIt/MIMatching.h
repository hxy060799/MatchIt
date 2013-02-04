//
//  MIMatching.h
//  MatchIt
//
//  Created by Bill on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MIPositionConvert.h"
#import "MIBlockManager.h"
#import "MIConfig.h"

@class MIRoute;
@class MIMap;

@interface MIMatching : NSObject

+(NSMutableDictionary*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;

+(NSMutableDictionary*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;
+(MIRoute*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip;

+(NSMutableDictionary*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;
+(MIRoute*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip;

+(NSMutableDictionary*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;
+(MIRoute*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip;

//在算法部分没有完成之前,用这个方法把算法走过的方块标记出来,用来调试算法
+(void)markBlockWithNumber:(int)number position:(MIPosition*)position Manager:(MIBlockManager*)manager HorizontalFlip:(BOOL)flip;

+(MIPosition*)flipBlockWithPosition:(MIPosition*)position Flip:(BOOL)flip;

@end