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

@interface MIMatching : NSObject

+(BOOL)isAbleAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB;
+(BOOL)isMatchingAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

+(BOOL)isAbleBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB;
+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

+(BOOL)isAbleCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB;
+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

@end
