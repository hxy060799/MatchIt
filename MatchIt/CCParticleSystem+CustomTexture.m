//
//  CCParticleSystem+CustomTexture.m
//  MatchIt
//
//  Created by Bill on 13-2-16.
//
//

#import "CCParticleSystem+CustomTexture.h"

@implementation CCParticleSystem (CCParticleSystem_CustomTexture)

-(id)initWithFile:(NSString *)plistFile CustomTextureFile:(NSString*)imageName{
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:plistFile];
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //拓展部分
    [dict setObject:[NSString stringWithString:imageName] forKey:@"textureFileName"];
    
	NSAssert( dict != nil, @"Particles: file not found");
	return [self initWithDictionary:dict];
}

+(id)particleWithFile:(NSString*)plistFile CustomTextureFile:(NSString*)imageName
{
	return [[[self alloc]initWithFile:plistFile CustomTextureFile:imageName]autorelease];
}

@end