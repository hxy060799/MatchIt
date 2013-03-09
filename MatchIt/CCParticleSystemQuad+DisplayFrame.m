//
//  CCParticleSystemQuad+DisplayFrame.m
//  MatchIt
//
//  Created by Bill on 13-2-16.
//
//

#import "CCParticleSystemQuad+DisplayFrame.h"

#import "CCFileUtils.h"
#import "CCSpriteFrameCache.h"

@implementation CCParticleSystemQuad(CCParticleSystem_DisplayFrame)

-(id)initWithFile:(NSString *)plistFile DisplayFrameName:(NSString *)frameName{
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:plistFile];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
	NSAssert( dict != nil, @"Particles: file not found");
    
    CCParticleSystemQuad *ret=[self initWithDictionary:dict];
    
    [ret setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:frameName]];
    
    return ret;
}

+(id)particleWithFile:(NSString*)plistFile DisplayFrameName:(NSString *)frameName{
	return [[[self alloc]initWithFile:plistFile DisplayFrameName:frameName]autorelease];
}

@end