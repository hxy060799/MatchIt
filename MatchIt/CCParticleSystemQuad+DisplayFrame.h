//
//  CCParticleSystemQuad+DisplayFrame.h
//  MatchIt
//
//  Created by Bill on 13-2-16.
//
//

#import "CCParticleSystemQuad.h"

@interface CCParticleSystemQuad(CCParticleSystem_DisplayFrame)

-(id)initWithFile:(NSString *)plistFile DisplayFrameName:(NSString*)frameName;


+(id)particleWithFile:(NSString*)plistFile DisplayFrameName:(NSString*)frameName;

@end