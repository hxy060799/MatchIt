//
//  MIRoute.h
//  MatchIt
//
//  Created by mac on 13-2-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIRoute : NSObject{
    NSMutableArray *routeVertexes;//路径顶点(折点)
    NSMutableArray *throughPoints;//路径穿过点
}

@property(retain,nonatomic)NSMutableArray *routeVertexes;
@property(retain,nonatomic)NSMutableArray *throughPoints;

-(id)init;
+(id)route;

-(id)initWithRouteVertexes:(NSMutableArray*)vertexes;
+(id)routeWithRouteVertexes:(NSMutableArray*)vertexes;

-(void)checkVertexes;
-(void)parseVerteses;

@end
