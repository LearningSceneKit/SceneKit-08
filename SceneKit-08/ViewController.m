//
//  ViewController.m
//  SceneKit-08
//
//  Created by ShiWen on 2017/6/22.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property(nonatomic,strong)SCNView *mScnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box2.jpg"];
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, -10, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.position = SCNVector3Make(0, 0, 30);
    cameraNode.camera = camera;
    [self.mScnView.scene.rootNode addChildNode:cameraNode];
    [self.mScnView.scene.rootNode addChildNode:floorNode];
    
    
    for (int i =0; i < 40; i++) {
        [self.mScnView.scene.rootNode addChildNode:[self creatStaticBody]];
    }
    for (int i = 0; i<500; i++) {
        [self.mScnView.scene.rootNode addChildNode:[self creatDynamicBody]];
    }
    
}
//静态身体
-(SCNNode *)creatStaticBody{
    SCNBox *box = [SCNBox boxWithWidth:1 height:4 length:1 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box2.jpg"];
    SCNNode *node = [SCNNode nodeWithGeometry:box];
    node.physicsBody = [SCNPhysicsBody dynamicBody];
    node.position = SCNVector3Make(arc4random()%10-5, -9, -10*arc4random()%5);
    return node;
}
//动态身体 更接近于真实情况
-(SCNNode *)creatDynamicBody{
    SCNSphere *sphere = [SCNSphere sphereWithRadius:1];
    sphere.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box1.jpg"];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(arc4random()%10-5, 10, -10*arc4random()%5);
    
    sphereNode.physicsBody = [SCNPhysicsBody dynamicBody];
    return sphereNode;
}
//静态初始状态不移动
-(SCNNode *)creatKinematicBody{
    SCNSphere *sphere = [SCNSphere sphereWithRadius:1];
    sphere.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box1.jpg"];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(arc4random()%10-5, 10, -10*arc4random()%5);
//静态身体
    sphereNode.physicsBody = [SCNPhysicsBody kinematicBody];
//    移动
    SCNAction *moveAction = [SCNAction moveTo:SCNVector3Make(sphereNode.position.x, -9.5, sphereNode.position.z) duration:4];
    [sphereNode runAction:moveAction];
    
    return sphereNode;
}
-(SCNView*)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.scene = [SCNScene scene];
        _mScnView.allowsCameraControl = YES;
        
    }
    return _mScnView;
}



@end
