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

@implementation MIMatching

+(NSMutableDictionary*)isMatchingWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
    //A
    for(int i=0;i<=2;i+=2){
        MIRoute *route=[self isMatchingAWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipNone Spin:i]];
        if(route!=nil){
            [result setObject:route forKey:@"Route"];
            return result;
        }
    }
    //B
    for(int i=0;i<=1;i++){
        for(int j=0;j<=1;j++){
            MIRoute *route=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(route!=nil){
                [result setObject:route forKey:@"Route"];
                return result;
            }
        }
    }
    //C
    for(int i=0;i<=1;i++){
        for(int j=0;j<4;j++){
            MIRoute *route=[self isMatchingCWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(route!=nil){
                [result setObject:route forKey:@"Route"];
                return result;
            }
        }
    }
    //D
    for(int i=0;i<=1;i++){
        for(int j=0;j<=2;j+=2){
            MIRoute *route=[self isMatchingDWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:i Spin:j]];
            if(route!=nil){
                [result setObject:route forKey:@"Route"];
                return result;
            }
        }
    }
      
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    
    return result;
}

+(MIRoute*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    BOOL isMatched=YES;
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if(blockA.y==blockB.y){
        //横着
        if(blockA.x>blockB.x){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        for(int i=blockA.x+1;i<blockB.x;i++){
            MIPosition *position=position=[MIPositionConvert convertWithConversion:conversion X:i Y:blockA.y inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            
            [routeVertexes addObject:blockA];
            [routeVertexes addObject:blockB];
            
            routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
            
            return [MIRoute routeWithRouteVertexes:routeVertexes];
        }else{
            return nil;
        }
        
    }else{
        return nil;
    }
}

+(MIRoute*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    BOOL isMatched=YES;
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)){
        //让方块A在左上
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
    	//向右
        for(int i=blockA.x+1;i<=blockB.x;i++){
            MIPosition *position=position=[MIPositionConvert convertWithConversion:conversion X:i Y:blockA.y inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
        //向下
        for(int i=blockA.y-1;i>blockB.y;i--){
            MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:blockB.x Y:i inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            
            [routeVertexes addObject:blockA];
            [routeVertexes addObject:[MIPosition positionWithX:blockB.x Y:blockA.y]];
            [routeVertexes addObject:blockB];
            
            routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
            
            return [MIRoute routeWithRouteVertexes:routeVertexes];
        }else{
            return nil;
        }
        
    }else{
        return nil;
    }
    
}

+(MIRoute*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    BOOL isMatched=YES;
    
    NSLog(@"A x:%i y:%i",blockA.x,blockA.y);
    NSLog(@"B x:%i y:%i",blockB.x,blockB.y);
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    NSLog(@"A x:%i y:%i",blockA.x,blockA.y);
    NSLog(@"B x:%i y:%i",blockB.x,blockB.y);
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)||(blockA.y==blockB.y)){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        if(blockA.y<[MIPositionConvert heightWithConversion:conversion]-1){
            isMatched=YES;
            //上方
            //公共部分
            for(int i=blockA.y;i>blockB.y;i--){
                MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:blockB.x Y:i inverse:YES];
                if([map blockAtX:position.x Y:position.y]!=0){
                    return nil;
                }
            }
            for(int j=blockA.y+1;j<[MIPositionConvert heightWithConversion:conversion];j++){
                isMatched=YES;
                //左右两边
                for(int i=blockA.y+1;i<=j;i++){
                    MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:blockA.x Y:i inverse:YES];
                    if([map blockAtX:position.x Y:position.y]!=0){
                        isMatched=NO;
                        break;
                    }
                    position=[MIPositionConvert convertWithConversion:conversion X:blockB.x Y:i inverse:YES];
                    if([map blockAtX:position.x Y:position.y]!=0){
                        isMatched=NO;
                        break;
                    }
                }
                //上面
                for(int i=blockA.x+1;i<blockB.x;i++){
                    MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:i Y:j inverse:YES];
                    if([map blockAtX:position.x Y:position.y]!=0){
                        isMatched=NO;
                    }
                }
                
                if(isMatched==YES){
                    NSMutableArray *routeVertexes=[NSMutableArray array];
                    
                    [routeVertexes addObject:blockA];
                    [routeVertexes addObject:[MIPosition positionWithX:blockA.x Y:j]];
                    [routeVertexes addObject:[MIPosition positionWithX:blockB.x Y:j]];
                    [routeVertexes addObject:blockB];
                    
                    routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
                    
                    return [MIRoute routeWithRouteVertexes:routeVertexes];
                }
            }
        }
    }
    return nil;
}

+(MIRoute*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    
    BOOL isMatched=YES;
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if(((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y))&&(abs(blockA.y-blockB.y)>=1)){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        //右→下→右
        for(int i=blockA.x+1;i<blockB.x;i++){
            isMatched=YES;
            //上段
            for(int j=blockA.x+1;j<=i;j++){
                MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:j Y:blockA.y inverse:YES];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                    break;
                }
            }
            //中间
            for(int j=blockA.y-1;j>blockB.y;j--){
                MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:i Y:j inverse:YES];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                    break;
                }
            }
            //下段
            for(int j=i;j<blockB.x;j++){
                MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:j Y:blockB.y inverse:YES];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            if(isMatched==YES){
                NSMutableArray *routeVertexes=[NSMutableArray array];
                
                [routeVertexes addObject:blockA];
                [routeVertexes addObject:[MIPosition positionWithX:i Y:blockA.y]];
                [routeVertexes addObject:[MIPosition positionWithX:i Y:blockB.y]];
                [routeVertexes addObject:blockB];
                
                routeVertexes=[MIPositionConvert convertWithConversion:conversion Positions:routeVertexes inverse:YES];
                
                return [MIRoute routeWithRouteVertexes:routeVertexes];
            }
        }
        
        return nil;
    }else{
        return NO;
    }
}

@end
