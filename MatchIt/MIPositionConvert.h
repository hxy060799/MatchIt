//
//  MIPositionConvert.h
//  MatchIt
//
//  Created by Bill on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>

#ifndef MatchIt_MIPositionConvert_h
#define MatchIt_MIPositionConvert_h

typedef enum {
    MIPositionConvertNone=0,
    MIPositionConvertFlipToLeft=1,
    MIPositionConvertFlipToRight=1
}MIPositionConvert;

struct MIPosition{
    int x;
    int y;
};

struct MIPosition MIPositionMake(int x,int y);

int MIPositionToIndex(int x,int y);
struct MIPosition MIIndexToPositon(int i);

struct MIPosition MIScreenToPosition(float x,float y);

int MIBlockISInArea(int x,int y);

struct MIPosition MIConvertWithPositionConvert(struct MIPosition position,MIPositionConvert positionConvert);

#endif
