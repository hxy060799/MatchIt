//
//  MIRoute.m
//  MatchIt
//
//  Created by mac on 13-2-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MIRoute.h"
#import "MIPositionConvert.h"

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

-(void)checkVertexes{

}

-(void)parseVerteses{
    for(int i=0;i<routeVertexes.count-1;i++){
        
        //向右
        
    }
}



@end
