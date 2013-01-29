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

+(BOOL)isMatchingAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager;

+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

+(BOOL)isMatchingDWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

@end
