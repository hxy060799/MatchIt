//
//  MIMatching.m
//  MatchIt
//
//  Created by Bill on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MIMatching.h"

#import "MIBlock.h"
#import "MIMap.h"
#import "MIRoute.h"
#import "MIMatchingResult.h"

@implementation MIMatching

+(MIMatchingResult*)isMatchingWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    MIMatchingResult *result=[MIMatchingResult resultWithMatched:YES];
    
    //A
    for(int i=0;i<=2;i+=2){
        MIMatchingResult *result_=[self isMatchingAWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipNone Spin:i]];
        if(result_.matched){
            result.route=result_.route;
            return result;
        }
    }
    //B
    for(int i=0;i<=1;i++){
        for(int j=0;j<=1;j++){
            MIMatchingResult *result_=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(result_.matched){
                result.route=result_.route;
                return result;
            }
        }
    }
    //C
    for(int i=0;i<=1;i++){
        for(int j=0;j<4;j++){
            MIMatchingResult *result_=[self isMatchingCWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(result_.matched){
                result.route=result_.route;
                return result;
            }
        }
    }
    //D
    for(int i=0;i<=1;i++){
        for(int j=0;j<=2;j+=2){
            MIMatchingResult *result_=[self isMatchingDWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(result_.matched){
                result.route=result_.route;
                return result;
            }
        }
    }
    
    result.matched=NO;
    
    return result;
}

+(MIMatchingResult*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    BOOL isMatched=YES;
    
    //横着
    if(blockA.x>blockB.x){
        MIPosition *positionTemp=blockB;
        blockB=blockA;
        blockA=positionTemp;
    }
    
    if(blockA.y!=blockB.y){
        isMatched=NO;
    }
    
    if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.x+1 MoveablePointEnd:blockB.x-1 StaticPoint:blockA.y IsXMoveable:YES Map:map Conversion:conversion]){
        isMatched=NO;
    }
    
    if(isMatched){
        //如果路线成立
        NSMutableArray *routeVertexes=[NSMutableArray array];
        
        [routeVertexes addObject:blockA];
        [routeVertexes addObject:blockB];
        
        routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
        
        return [MIMatchingResult resultWithRouteVertexes:routeVertexes];
    }else{
        return [MIMatchingResult resultWithMatched:NO];
    }
}

+(MIMatchingResult*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    BOOL isMatched=YES;
    
    //让方块A在左上
    if(blockA.x>blockB.x && blockA.y<blockB.y){
        MIPosition *positionTemp=blockB;
        blockB=blockA;
        blockA=positionTemp;
    }
    
    if(!(blockA.x<blockB.x && blockA.y>blockB.y)){
        isMatched=NO;
    }
    
    //向右
    if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.x+1 MoveablePointEnd:blockB.x StaticPoint:blockA.y IsXMoveable:YES Map:map Conversion:conversion]){
        isMatched=NO;
    }
    //向下
    if(![MIMatching isMatchingInLineWithMoveablePointStart:blockB.y+1 MoveablePointEnd:blockA.y-1 StaticPoint:blockB.x IsXMoveable:NO Map:map Conversion:conversion]){
        isMatched=NO;
    }
    
    if(isMatched==YES){
        NSMutableArray *routeVertexes=[NSMutableArray array];
        
        [routeVertexes addObject:blockA];
        [routeVertexes addObject:[MIPosition positionWithX:blockB.x Y:blockA.y]];
        [routeVertexes addObject:blockB];
        
        routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
        
        return [MIMatchingResult resultWithRouteVertexes:routeVertexes];
    }else{
        return [MIMatchingResult resultWithMatched:NO];
    }
}

+(MIMatchingResult*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if(blockA.x>blockB.x && blockA.y<blockB.y){
        MIPosition *positionTemp=blockB;
        blockB=blockA;
        blockA=positionTemp;
    }
    
    if(!(blockA.x<blockB.x && blockA.y>blockB.y)&&!(blockA.y==blockB.y)){
        return [MIMatchingResult resultWithMatched:NO];
    }
    
    if(!(blockA.y<[MIPositionConvert heightWithConversion:conversion]-1)){
        return [MIMatchingResult resultWithMatched:NO];
    }
    
    //上方
    //公共部分
    if(![MIMatching isMatchingInLineWithMoveablePointStart:blockB.y+1 MoveablePointEnd:blockA.y StaticPoint:blockB.x IsXMoveable:NO Map:map Conversion:conversion]){
        return [MIMatchingResult resultWithMatched:NO];
    }
    
    for(int j=blockA.y+1;j<[MIPositionConvert heightWithConversion:conversion];j++){
        BOOL isMatched=YES;
        //左右两边
        if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.y+1 MoveablePointEnd:j StaticPoint:blockA.x IsXMoveable:NO Map:map Conversion:conversion]){
            isMatched=NO;
        }
        if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.y+1 MoveablePointEnd:j StaticPoint:blockB.x IsXMoveable:NO Map:map Conversion:conversion]){
            isMatched=NO;
        }
        
        //上面
        if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.x+1 MoveablePointEnd:blockB.x-1 StaticPoint:j IsXMoveable:YES Map:map Conversion:conversion]){
            isMatched=NO;
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            
            [routeVertexes addObject:blockA];
            [routeVertexes addObject:[MIPosition positionWithX:blockA.x Y:j]];
            [routeVertexes addObject:[MIPosition positionWithX:blockB.x Y:j]];
            [routeVertexes addObject:blockB];
            
            routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
            
            return [MIMatchingResult resultWithRouteVertexes:routeVertexes];
        }
    }
    return [MIMatchingResult resultWithMatched:NO];
}

+(MIMatchingResult*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if(blockA.x>blockB.x && blockA.y<blockB.y){
        MIPosition *positionTemp=blockB;
        blockB=blockA;
        blockA=positionTemp;
    }
    if(!(blockA.x<blockB.x && blockA.y>blockB.y)||!(abs(blockA.y-blockB.y)>=1)){
        return [MIMatchingResult resultWithMatched:NO];
    }
    //右→下→右
    for(int i=blockA.x+1;i<blockB.x;i++){
        BOOL isMatched=YES;
        //上段
        if(![MIMatching isMatchingInLineWithMoveablePointStart:blockA.x+1 MoveablePointEnd:i StaticPoint:blockA.y IsXMoveable:YES Map:map Conversion:conversion]){
            isMatched=NO;
        }
        //中间
        if(![MIMatching isMatchingInLineWithMoveablePointStart:blockB.y+1 MoveablePointEnd:blockA.y-1 StaticPoint:i IsXMoveable:NO Map:map Conversion:conversion]){
            isMatched=NO;
        }
        //下段
        if(![MIMatching isMatchingInLineWithMoveablePointStart:i MoveablePointEnd:blockB.x-1 StaticPoint:blockB.y IsXMoveable:YES Map:map Conversion:conversion]){
            isMatched=NO;
        }
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            
            [routeVertexes addObject:blockA];
            [routeVertexes addObject:[MIPosition positionWithX:i Y:blockA.y]];
            [routeVertexes addObject:[MIPosition positionWithX:i Y:blockB.y]];
            [routeVertexes addObject:blockB];
            
            routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
            
            return [MIMatchingResult resultWithRouteVertexes:routeVertexes];
        }
    }
    return [MIMatchingResult resultWithMatched:NO];
}

+(BOOL)isMatchingInLineWithMoveablePointStart:(int)moveablePointStart MoveablePointEnd:(int)moveablePointEnd StaticPoint:(int)staticPoint IsXMoveable:(BOOL)isXMoveable Map:(MIMap*)map Conversion:(MIConversion *)conversion{
    for(int i=moveablePointStart;i<=moveablePointEnd;i++){
        MIPosition *position=nil;
        if(isXMoveable){
            position=[MIPositionConvert convertWithConversion:conversion X:i Y:staticPoint inverse:YES];
        }else{
            position=[MIPositionConvert convertWithConversion:conversion X:staticPoint Y:i inverse:YES];
        }
        if([map blockAtX:position.x Y:position.y]!=0){
            return NO;
        }
    }
    return YES;
}

@end
