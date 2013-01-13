//
//  MIPositionConvert.c
//  MatchIt
//
//  Created by Bill on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include <math.h>

#include "MIConfig.h"
#include "MIPositionConvert.h"


struct MIPosition MIPositionMake(int x,int y){
    struct MIPosition position;
    
    position.x=x;
    position.y=y;
    
    return position;
}


int MIPositionToIndex(int x,int y){
    return y*BLOCKS_XCOUNT+x;
}

struct MIPosition MIIndexToPositon(int i){
    return MIPositionMake(i%BLOCKS_XCOUNT, floor(i/BLOCKS_XCOUNT)) ;
}


struct MIPosition MIScreenToPosition(float x,float y){
    int x_=floor((x-BLOCKS_LEFT_X)/BLOCKS_SIZE);
    int y_=floor((y-BLOCKS_BOTTOM_Y)/BLOCKS_SIZE);
    
    return MIPositionMake(x_, y_);
}

int MIBlockISInArea(int x,int y){
    if(x>BLOCKS_XCOUNT-1){
        return 0;
    }
    if(x<0){
        return 0;
    }
    if(y>BLOCKS_YCOUNT-1){
        return 0;
    }
    if(y<0){
        return 0;
    }
    return 1;
}