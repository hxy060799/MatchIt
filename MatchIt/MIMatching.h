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

+(NSMutableDictionary*)isMatchingWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;

+(MIRoute*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;

+(MIRoute*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;

+(MIRoute*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion HorizontalFlip:(BOOL)flip;

+(MIRoute*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip;

+(MIPosition*)flipBlockWithPosition:(MIPosition*)position Flip:(BOOL)flip;

@end