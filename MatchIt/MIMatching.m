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

+(NSMutableDictionary*)isMatchingAWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    //第一种直线方案不进行坐标转换,直接把另外一种方案放到里面.
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    
    BOOL isMatched=YES;
    
    if(blockA.y==blockB.y){
        //横着
        if(blockA.x>blockB.x){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        for(int i=blockA.x+1;i<blockB.x;i++){
            if([map blockAtX:i Y:blockA.y]!=0){
                isMatched=NO;
            }
        }
    }else if(blockA.x==blockB.x){
        //竖着
        if(blockA.y>blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        for(int i=blockA.y+1;i<blockB.y;i++){
            if([map blockAtX:blockA.x Y:i]!=0){
                isMatched=NO;
            }
        }
    }
    
    if(isMatched){
        [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
        [result setObject:[MIRoute routeWithRouteVertexes:[NSMutableArray arrayWithObjects:blockA,blockB,nil]] forKey:@"Route"];
    }
    
    return result;
}

+(NSMutableDictionary*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    MIRoute *routeA=[self isMatchingBWithA:blockA B:blockB Map:map HorizontalFlip:NO];
    if(routeA!=nil){
        [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
        [result setObject:routeA forKey:@"Route"];
    }else{
        MIRoute *routeB=[self isMatchingBWithA:blockA B:blockB Map:map HorizontalFlip:YES];
        if(routeB!=nil){
            [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
            [result setObject:routeB forKey:@"Route"];
        }
    }
    return result;
}

+(MIRoute*)isMatchingBWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip{
    BOOL isMatched=YES;
    
    blockA=[self flipBlockWithPosition:blockA Flip:flip];
    blockB=[self flipBlockWithPosition:blockB Flip:flip];
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)){
        //方块A在左上
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            MIPosition *positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //先右后下
        for(int i=blockA.x+1;i<=blockB.x;i++){
            MIPosition *position=[MIPosition positionWithX:i Y:blockA.y];
            position=[self flipBlockWithPosition:position Flip:flip];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
            }
        }
        
        for(int i=blockA.y-1;i>blockB.y;i--){
            MIPosition *position=[MIPosition positionWithX:blockB.x Y:i];
            position=[self flipBlockWithPosition:position Flip:flip];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
            }
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
            [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockB.x Y:blockA.y] Flip:flip]];
            [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
            return [MIRoute routeWithRouteVertexes:routeVertexes];
        }
        
        BOOL isMatched=YES;
        
        //先下后右
        for(int i=blockA.y-1;i>=blockB.y;i--){
            MIPosition *position=[MIPosition positionWithX:blockA.x Y:i];
            position=[self flipBlockWithPosition:position Flip:flip];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
            }
        }
        
        for(int i=blockA.x+1;i<blockB.x;i++){
            MIPosition *position=[MIPosition positionWithX:i Y:blockB.y];
            position=[self flipBlockWithPosition:position Flip:flip];
            if([map blockAtX:position.x Y:position.y]!=0){
                isMatched=NO;
            }
        }
        
        if(isMatched==YES){
            NSMutableArray *routeVertexes=[NSMutableArray array];
            [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
            [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockA.x Y:blockB.y] Flip:flip]];
            [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
            return [MIRoute routeWithRouteVertexes:routeVertexes];
        }
    }
    return nil;
}

+(NSMutableDictionary*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    MIRoute *routeA=[self isMatchingCWithA:blockA B:blockB Map:map HorizontalFlip:NO];
    if(routeA!=nil){
        [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
        [result setObject:routeA forKey:@"Route"];
    }else{
        MIRoute *routeB=[self isMatchingCWithA:blockA B:blockB Map:map HorizontalFlip:YES];
        if(routeB!=nil){
            [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
            [result setObject:routeB forKey:@"Route"];
        }
    }
    return result;
}


+(MIRoute*)isMatchingCWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip{
    BOOL isMatched=YES;
    
    blockA=[self flipBlockWithPosition:blockA Flip:flip];
    blockB=[self flipBlockWithPosition:blockB Flip:flip];
    
    if((blockA.x<=blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<=blockB.y)){
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
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            for(int j=blockA.y+1;j<BLOCKS_YCOUNT;j++){
                isMatched=YES;
                //左右两边
                for(int i=blockA.y+1;i<=j;i++){
                    MIPosition *position=[MIPosition positionWithX:blockA.x Y:i];
                    position=[self flipBlockWithPosition:position Flip:flip];
                    if([map blockAtX:position.x Y:position.y]!=0){
                        isMatched=NO;
                    }
                    position=[MIPosition positionWithX:blockB.x Y:i];
                    position=[self flipBlockWithPosition:position Flip:flip];
                    if([map blockAtX:position.x Y:position.y]!=0){
                        isMatched=NO;
                    }
                }
                //上面
                if(isMatched){
                    for(int i=blockA.x+1;i<blockB.x;i++){
                        MIPosition *position=[MIPosition positionWithX:i Y:j];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    if(isMatched==YES){
                        NSMutableArray *routeVertexes=[NSMutableArray array];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockA.x Y:j] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockB.x Y:j] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
                        return [MIRoute routeWithRouteVertexes:routeVertexes];
                    }
                }
            }
        }
        if(blockB.y>0){
            isMatched=YES;
            //下方
            //公共部分
            for(int i=blockA.y-1;i>=blockB.y;i--){
                MIPosition *position=[MIPosition positionWithX:blockA.x Y:i];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            
            if(isMatched){
                for(int j=blockB.y-1;j>=0;j--){
                    isMatched=YES;
                    //左右两边
                    for(int i=j;i<=blockB.y-1;i++){
                        MIPosition *position=[MIPosition positionWithX:blockA.x Y:i];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                        position=[MIPosition positionWithX:blockB.x Y:i];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    //下面
                    for(int i=blockA.x+1;i<blockB.x;i++){
                        MIPosition *position=[MIPosition positionWithX:i Y:j];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    if(isMatched==YES){
                        NSMutableArray *routeVertexes=[NSMutableArray array];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockA.x Y:j] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:blockB.x Y:j] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
                        return [MIRoute routeWithRouteVertexes:routeVertexes];
                    }
                }
            }
        }
        if(blockA.x>0){
            isMatched=YES;
            //左方
            //公共部分
            for(int i=blockA.x;i<blockB.x;i++){
                MIPosition *position=[MIPosition positionWithX:i Y:blockB.y];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            if(isMatched){
                for(int j=blockA.x-1;j>=0;j--){
                    isMatched=YES;
                    //上下两边
                    for(int i=j;i<=blockA.x-1;i++){
                        MIPosition *position=[MIPosition positionWithX:i Y:blockA.y];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                        position=[MIPosition positionWithX:i Y:blockB.y];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    
                    //左面
                    for(int i=blockA.y-1;i>blockB.y;i--){
                        MIPosition *position=[MIPosition positionWithX:j Y:i];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    if(isMatched==YES){
                        NSMutableArray *routeVertexes=[NSMutableArray array];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:j Y:blockA.y] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:j Y:blockB.y] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
                        return [MIRoute routeWithRouteVertexes:routeVertexes];
                    }
                }
            }
        }
        
        if(blockB.x<BLOCKS_XCOUNT-1){
            isMatched=YES;
            //右方
            //公共部分
            for(int i=blockA.x+1;i<=blockB.x;i++){
                MIPosition *position=[MIPosition positionWithX:i Y:blockA.y];
                position=[self flipBlockWithPosition:position Flip:flip];
                if([map blockAtX:position.x Y:position.y]!=0){
                    isMatched=NO;
                }
            }
            if(isMatched) {
                for(int j=blockB.x+1;j<BLOCKS_XCOUNT;j++){
                    isMatched=YES;
                    //上下两边
                    for(int i=blockB.x+1;i<=j;i++){
                        for(int i=j;i<=blockA.x-1;i++){
                            MIPosition *position=[MIPosition positionWithX:i Y:blockA.y];
                            position=[self flipBlockWithPosition:position Flip:flip];
                            if([map blockAtX:position.x Y:position.y]!=0){
                                isMatched=NO;
                            }
                            position=[MIPosition positionWithX:i Y:blockB.y];
                            position=[self flipBlockWithPosition:position Flip:flip];
                            if([map blockAtX:position.x Y:position.y]!=0){
                                isMatched=NO;
                            }
                        }
                    }
                    //右面
                    for(int i=blockA.y-1;i>blockB.y;i--){
                        MIPosition *position=[MIPosition positionWithX:j Y:i];
                        position=[self flipBlockWithPosition:position Flip:flip];
                        if([map blockAtX:position.x Y:position.y]!=0){
                            isMatched=NO;
                        }
                    }
                    if(isMatched==YES){
                        NSMutableArray *routeVertexes=[NSMutableArray array];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockA Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:j Y:blockA.y] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:[MIPosition positionWithX:j Y:blockB.y] Flip:flip]];
                        [routeVertexes addObject:[self flipBlockWithPosition:blockB Flip:flip]];
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


+(NSMutableDictionary*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [result setObject:[NSNumber numberWithBool:NO] forKey:@"IsMatched"];
    MIRoute *routeA=[self isMatchingDWithA:blockA B:blockB Map:map HorizontalFlip:NO];
    if(routeA!=nil){
        [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
        [result setObject:routeA forKey:@"Route"];
    }else{
        MIRoute *routeB=[self isMatchingDWithA:blockA B:blockB Map:map HorizontalFlip:YES];
        if(routeB!=nil){
            [result setObject:[NSNumber numberWithBool:YES] forKey:@"IsMatched"];
            [result setObject:routeB forKey:@"Route"];
        }
    }
    return result;
}

+(MIRoute*)isMatchingDWithA:(MIPosition*)blockA B:(MIPosition*)blockB Map:(MIMap*)map HorizontalFlip:(BOOL)flip{
    BOOL isMatched=YES;
    
    blockA=[self flipBlockWithPosition:blockA Flip:flip];
    blockB=[self flipBlockWithPosition:blockB Flip:flip];
    
    if(((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y))&&(abs(blockA.y-blockB.y)>1)){
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

+(void)markBlockWithNumber:(int)number position:(MIPosition*)position Manager:(MIBlockManager*)manager HorizontalFlip:(BOOL)flip{
    MIPosition *blockTemp=nil;
    if(flip){
        blockTemp=[MIPositionConvert horizontalFlipWithPosition:[MIPosition positionWithX:position.x Y:position.y]];
    }else{
        blockTemp=[MIPosition positionWithX:position.x Y:position.y];
    }
    [[manager blockAtX:blockTemp.x Y:blockTemp.y]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",number]];
}

+(MIPosition*)flipBlockWithPosition:(MIPosition*)position Flip:(BOOL)flip{
    if(flip){
        return [MIPositionConvert horizontalFlipWithPosition:[MIPosition positionWithX:position.x Y:position.y]];
    }else{
        return position;
    }
}

@end
