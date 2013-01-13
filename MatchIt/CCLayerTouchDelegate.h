//
//  CCLayerTouchDelegate.h
//  MatchIt
//
//  Created by Bill on 13-1-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCLayerTouchDelegate <NSObject>
@optional
-(void)ccLayerTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccLayerTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccLayerTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccLayerTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end
