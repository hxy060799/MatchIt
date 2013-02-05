//
//  MIRoute.m
//  MatchIt
//
//  Created by mac on 13-2-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MIRoute.h"
#import "MIBlockManager.h"

@implementation MIRoute

@synthesize routeVertexes;
@synthesize throughPoints;

-(id)init{
    if(self=[super init]){
        self.routeVertexes=[[NSMutableArray alloc]init];
        self.throughPoints=[[NSMutableArray alloc]init];
    }
    return self;
}

+(id)route{
    return [[[self alloc]init]autorelease];
}

-(id)initWithRouteVertexes:(NSMutableArray*)vertexes{
    if(self=[super init]){
        self.routeVertexes=[vertexes copy];
        self.throughPoints=[[NSMutableArray alloc]init];
    }
    return self;
}

+(id)routeWithRouteVertexes:(NSMutableArray*)vertexes{
    return [[[self alloc]initWithRouteVertexes:vertexes]autorelease];
}

-(void)dealloc{
    [routeVertexes release];
    [throughPoints release];
    [super dealloc];
}

-(BOOL)checkVertexes{
    if(routeVertexes.count>0){
        for(int i=0;i<routeVertexes.count-1;i++){
            MIPosition *thisBlock=[self vertexAtIndex:i];
            MIPosition *nextBlock=[self vertexAtIndex:i+1];
            //不等
            if(thisBlock.x!=nextBlock.x && thisBlock.y!=nextBlock.y){
                NSLog(@"Error01!");
                return NO;
            }
            //相等
            if(thisBlock.x==nextBlock.x && thisBlock.y==nextBlock.y){
                NSLog(@"Error02!");
                return NO;
            }
        }
    }else{
        return NO;
    }
    return YES;
}

-(MIDirection)makeVertexDirectionWithVertex:(MIPosition*)vertex BlockA:(MIPosition*)blockA BlockB:(MIPosition*)blockB{
    if(vertex.x==blockA.x && blockA.x==blockB.x){
        return MIDirectionVertical;
    }
    
    if(vertex.y==blockA.y && blockA.y==blockB.y){
        return MIDirectionHorizontal;
    }
    
    if(blockB.x<blockA.x){
        MIPosition *positionTemp=blockB;
        blockB=blockA;
        blockA=positionTemp;
    }
    
    if(blockA.y>blockB.y){
        if(vertex.y==blockA.y){
            return MIDirectionRightTop;
        }else if(vertex.y==blockB.y){
            return MIDirectionLeftBottom;
        }
    }else if(blockA.y<blockB.y){
        if(vertex.y==blockA.y){
            return MIDirectionRightBottom;
        }else if(vertex.y==blockB.y){
            return MIDirectionLeftTop;
        }
    }
    return MIDirectionNone;
}

-(void)parseVerteses{
    for(MIPosition *position in [self routeVertexes]){
        NSLog(@"****x:%i,y:%i",position.x,position.y);
    }
    
    if([self checkVertexes]==NO){
        return;
    }
    
    //确定原点方向,并在路线中加入原点
    for(int i=1;i<routeVertexes.count-1;i++){
        [self vertexAtIndex:i].direction=[self makeVertexDirectionWithVertex:[self vertexAtIndex:i] BlockA:[self vertexAtIndex:i-1] BlockB:[self vertexAtIndex:i+1]];
        [throughPoints addObject:[self vertexAtIndex:i]];
    }
    //生成路径
    for(int i=0;i<routeVertexes.count-1;i++){
        MIPosition *thisBlock=[self vertexAtIndex:i];
        MIPosition *nextBlock=[self vertexAtIndex:i+1];
        //向右
        if(thisBlock.x<nextBlock.x && thisBlock.y==nextBlock.y){
            for(int j=thisBlock.x+1;j<nextBlock.x;j++){
                MIPosition *position=[MIPosition positionWithX:j Y:thisBlock.y];
                position.direction=MIDirectionHorizontal;
                [throughPoints addObject:position];
            }
        }
        //向左
        if(thisBlock.x>nextBlock.x && thisBlock.y==nextBlock.y){
            for(int j=thisBlock.x-1;j>nextBlock.x;j--){
                MIPosition *position=[MIPosition positionWithX:j Y:thisBlock.y];
                position.direction=MIDirectionHorizontal;
                [throughPoints addObject:position];
            }
        }
        //向上
        if(thisBlock.y<nextBlock.y && thisBlock.x==nextBlock.x){
            for(int j=thisBlock.y+1;j<nextBlock.y;j++){
                MIPosition *position=[MIPosition positionWithX:thisBlock.x Y:j];
                position.direction=MIDirectionVertical;
                [throughPoints addObject:position];
            }
        }
        //向下
        if(thisBlock.y>nextBlock.y && thisBlock.x==nextBlock.x){
            for(int j=thisBlock.y-1;j>nextBlock.y;j--){
                MIPosition *position=[MIPosition positionWithX:thisBlock.x Y:j];
                position.direction=MIDirectionVertical;
                [throughPoints addObject:position];
            }
        }
    }
    //[throughPoints addObject:[routeVertexes objectAtIndex:routeVertexes.count-1]];
}

+(void)drawRouteWithRoute:(MIRoute*)route manager:(MIBlockManager*)manager{
    for(MIPosition *position in [route throughPoints]){
        NSLog(@"x:%i,y:%i",position.x,position.y);
        if(position.direction==MIDirectionHorizontal){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_Horizontal.png"];
        }else if(position.direction==MIDirectionVertical){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_Vertical.png"];
        }else if(position.direction==MIDirectionLeftBottom){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_LeftBottom.png"];
        }else if(position.direction==MIDirectionLeftTop){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_LeftTop.png"];
        }
        else if(position.direction==MIDirectionRightBottom){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_RightBottom.png"];
        }
        else if(position.direction==MIDirectionRightTop){
            [[manager blockAtX:position.x Y:position.y]setBlockRouteSpriteFrameWithFileName:@"Block_RightTop.png"];
        }
    }
}

-(MIPosition*)vertexAtIndex:(int)index{
    return (MIPosition*)[routeVertexes objectAtIndex:index];
}

@end
