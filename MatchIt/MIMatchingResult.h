//
//  MIMatchingResult.h
//  MatchIt
//
//  Created by Huniu on 13-2-18.
//
//

#import <Foundation/Foundation.h>

@class MIRoute;

@interface MIMatchingResult : NSObject{
    BOOL matched;
    MIRoute *route;
}

@property(assign,nonatomic)BOOL matched;
@property(retain,nonatomic)MIRoute *route;

-(id)initWithMatched:(BOOL)matched_;
+(id)resultWithMatched:(BOOL)matched_;

-(id)initWithRouteVertexes:(NSMutableArray*)routeVertexes;
+(id)resultWithRouteVertexes:(NSMutableArray*)routeVertexes;

@end
