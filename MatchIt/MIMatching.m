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
    /*
    MIRoute *route=[self isMatchingCWithA:blockA B:blockB Map:map Conversion:MIConversionNone HorizontalFlip:NO];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    route=[self isMatchingCWithA:blockA B:blockB Map:map Conversion:MIConversionPlus180Degrees HorizontalFlip:NO];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
     */
    /*
    //1
    MIRoute *route=[self isMatchingAWithA:blockA B:blockB Map:map Conversion:MIConversionNone];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    route=[self isMatchingAWithA:blockA B:blockB Map:map Conversion:MIConversionMinus90Degrees];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    */
    //2
    MIRoute *route=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipNone Spin:MISpinNone]];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    route=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipNone Spin:MISpin180Degrees]];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    route=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipHorizontal Spin:MISpinNone]];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
        route=[self isMatchingBWithA:blockA B:blockB Map:map Conversion:[MIConversion conversionWithFlip:MIFlipHorizontal Spin:MISpin180Degrees]];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    /*
    route=[self isMatchingBWithA:blockA B:blockB Map:map HorizontalFlip:YES];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    route=[self isMatchingCWithA:blockA B:blockB Map:map HorizontalFlip:NO];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    route=[self isMatchingCWithA:blockA B:blockB Map:map HorizontalFlip:YES];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    route=[self isMatchingDWithA:blockA B:blockB Map:map HorizontalFlip:NO];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    
    route=[self isMatchingDWithA:blockA B:blockB Map:map HorizontalFlip:YES];
    if(route!=nil){
        [result setObject:route forKey:@"Route"];
        return result;
    }
    */
    
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    
    return result;
}

+(MIRoute*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    BOOL isMatched=NO;
    
    //返回结果的时候,需要使用没有转换过的点
    MIPosition *blockA_=[MIPosition positionWithX:blockA.x Y:blockA.y];
    MIPosition *blockB_=[MIPosition positionWithX:blockB.x Y:blockB.y];
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if(blockA.y==blockB.y){
        isMatched=YES;
        //横着
        if(blockA.x>blockB.x){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        for(int i=blockA.x+1;i<blockB.x;i++){
            MIPosition *position=[MIPosition positionWithX:i Y:blockA.y];
            position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
    }
    
    if(isMatched){
        return [MIRoute routeWithRouteVertexes:[NSMutableArray arrayWithObjects:blockA_,blockB_,nil]];
    }
    
    return nil;
}

+(MIRoute*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion{
    BOOL isMatched=NO;
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)){
        isMatched=YES;
        //方块A在左上
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //先右后下
        for(int i=blockA.x+1;i<=blockB.x;i++){
            MIPosition *position=position=[MIPositionConvert convertWithConversion:conversion X:i Y:blockA.y inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
        
        for(int i=blockA.y-1;i>blockB.y;i--){
            MIPosition *position=[MIPositionConvert convertWithConversion:conversion X:blockB.x Y:i inverse:YES];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
                break;
            }
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            
            MIPosition *position=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:YES];
            [routeVertexes addObject:position];
            
            MIPosition *position2=[MIPositionConvert convertWithConversion:conversion X:blockB.x Y:blockA.y inverse:YES];
            [routeVertexes addObject:position2];
            
            MIPosition *position3=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:YES];
            [routeVertexes addObject:position3];
            
            return [MIRoute routeWithRouteVertexes:routeVertexes];
        }
    }
    return nil;
}

+(MIRoute*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map Conversion:(MIConversion*)conversion HorizontalFlip:(BOOL)flip{
    BOOL isMatched=NO;
    
    blockA=[MIPositionConvert convertWithConversion:conversion Position:blockA inverse:NO];
    blockB=[MIPositionConvert convertWithConversion:conversion Position:blockB inverse:NO];
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)||(blockA.x==blockB.x)||(blockA.y==blockB.y)){
        isMatched=YES;
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        if(blockA.y<BLOCKS_YCOUNT-1){
            isMatched=YES;
            //上方
            //公共部分
            for(int i=blockA.y;i>blockB.y;i--){
                MIPosition *position=[MIPosition positionWithX:blockB.x Y:i];
                position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                    break;
                }
            }
            if(isMatched){
                for(int j=blockA.y+1;j<BLOCKS_YCOUNT;j++){
                    isMatched=YES;
                    //左右两边
                    for(int i=blockA.y+1;i<=j;i++){
                        MIPosition *position=[MIPosition positionWithX:blockA.x Y:i];
                        position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                            break;
                        }
                        position=[MIPosition positionWithX:blockB.x Y:i];
                        position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                            break;
                        }
                    }
                    //上面
                    for(int i=blockA.x+1;i<blockB.x;i++){
                        MIPosition *position=[MIPosition positionWithX:i Y:j];
                        position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    if(isMatched==YES){
                        NSMutableArray *routeVertexes=[NSMutableArray array];
                        MIPosition *position=blockA;
                        position=[MIPositionConvert convertWithConversion:conversion Position:position inverse:YES];
                        [routeVertexes addObject:position];
                        
                        MIPosition *position2=[MIPosition positionWithX:blockA.x Y:j];
                        position2=[MIPositionConvert convertWithConversion:conversion Position:position2 inverse:YES];
                        [routeVertexes addObject:position2];
                        
                        MIPosition *position3=[MIPosition positionWithX:blockB.x Y:j];
                        position3=[MIPositionConvert convertWithConversion:conversion Position:position3 inverse:YES];
                        [routeVertexes addObject:position3];
                        
                        MIPosition *position4=blockB;
                        position4=[MIPositionConvert convertWithConversion:conversion Position:position4 inverse:YES];
                        [routeVertexes addObject:position4];
                        return [MIRoute routeWithRouteVertexes:routeVertexes];
                    }
                }
            }
        }   
        return nil;
    }else{
        return NO;
    }
    
}

+(MIRoute*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip{
    BOOL isMatched=NO;
    
    blockA=[self flipBlockWithPosition:blockA Flip:flip];
    blockB=[self flipBlockWithPosition:blockB Flip:flip];
    
    if(((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y))&&(abs(blockA.y-blockB.y)>1)){
        isMatched=YES;
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
                MIPosition *position=[MIPosition positionWithX:j Y:blockA.y];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            //中间
            for(int j=blockA.y-1;j>blockB.y;j--){
                MIPosition *position=[MIPosition positionWithX:i Y:j];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            //下段
            for(int j=i;j<blockB.x;j++){
                MIPosition *position=[MIPosition positionWithX:j Y:blockB.y];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            if(isMatched==YES){
                NSMutableArray *routeVertexes=[NSMutableArray array];
                [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:i Y:blockA.y] Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:i Y:blockB.y] Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
                return [MIRoute routeWithRouteVertexes:routeVertexes];
            }
        }
        
        //下→右→下
        for(int i=blockA.y-1;i>blockB.y;i--){
            isMatched=YES;
            //左段
            for(int j=blockA.y-1;j>=i;j--){
                MIPosition *position=[MIPosition positionWithX:blockA.x Y:j];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            //中间
            for(int j=blockA.x+1;j<blockB.x;j++){
                MIPosition *position=[MIPosition positionWithX:j Y:i];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            //右段
            for(int j=i;j>blockB.y;j--){
                MIPosition *position=[MIPosition positionWithX:blockB.x Y:j];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            if(isMatched==YES){
                NSMutableArray *routeVertexes=[NSMutableArray array];
                [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockA.x Y:i] Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockB.x Y:i] Flip:flip]];
                [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
                return [MIRoute routeWithRouteVertexes:routeVertexes];
            }
        }
        
        return nil;
    }else{
        return NO;
    }
}

+(MIPosition*)flipBlockWithPosition:(MIPosition*)position Flip:(BOOL)flip{
    if(flip){
        return [MIPositionConvert horizontalFlipWithPosition:[MIPosition positionWithX:position.x Y:position.y]];
    }else{
        return position;
    }
}

@end
