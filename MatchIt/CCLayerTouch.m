//
//  CCLayerTouch.m
//  MatchIt
//
//  Created by Bill on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CCLayerTouch.h"
#import "CCLayerTouchDelegate.h"

@implementation CCLayerTouch

@synthesize delegete;

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([delegete respondsToSelector:@selector(ccLayerTouchesBegan:withEvent:)]){
        [delegete ccLayerTouchesBegan:touches withEvent:event];
    }
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if([delegete respondsToSelector:@selector(ccLayerTouchesCancelled:withEvent:)]){
        [delegete ccLayerTouchesCancelled:touches withEvent:event];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if([delegete respondsToSelector:@selector(ccLayerTouchesEnded:withEvent:)]){
        [delegete ccLayerTouchesEnded:touches withEvent:event];
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if([delegete respondsToSelector:@selector(ccLayerTouchesMoved:withEvent:)]){
        [delegete ccLayerTouchesMoved:touches withEvent:event];
    }
}

-(void)dealloc{
    [super dealloc];
    [delegete release];
}

@end
