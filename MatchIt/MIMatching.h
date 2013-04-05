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

@class MIMap;
@class MIMatchingResult;

@interface MIMatching : NSObject

+(MIMatchingResult*)isMatchingWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map;

+(MIMatchingResult*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;

+(MIMatchingResult*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;

+(MIMatchingResult*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;

+(MIMatchingResult*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion;


@end