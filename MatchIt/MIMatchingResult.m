//
//  MIMatchingResult.m
//  MatchIt
//
//  Created by Huniu on 13-2-18.
//
//

#import "MIMatchingResult.h"
#import "MIRoute.h"

@implementation MIMatchingResult

@synthesize matched;
@synthesize route;

-(id)init{
    if(self=[super init]){
        matched=NO;
        route=[[MIRoute alloc]init];
    }
    return self;
}

-(void)dealloc{
    [route release];
    [super dealloc];
}

-(id)initWithMatched:(BOOL)matched_{
    if(self=[super init]){
        if(matched_){
            matched=YES;
        }else{
            matched=NO;
        }
    }
    return self;
}

+(id)resultWithMatched:(BOOL)matched_{
    return [[[self alloc]initWithMatched:matched_]autorelease];
}

-(id)initWithRouteVertexes:(NSMutableArray*)routeVertexes{
    if(self=[super init]){
        matched=YES;
        route=[[MIRoute alloc]initWithRouteVertexes:routeVertexes];
    }
    return self;
}

+(id)resultWithRouteVertexes:(NSMutableArray*)routeVertexes{
    return [[[self alloc]initWithRouteVertexes:routeVertexes]autorelease];
}

@end
