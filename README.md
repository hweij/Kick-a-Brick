# Kick-a-Brick Godot 4.1 VR demo project

This is a simple-as-possible demo for a Godot VR project.
I created it to get familiar with programming VR using this game engine.

The "game" consists of a VR-scene, a player, and a brick wall that can be destroyed by lasering
bricks with your right-hand controller.

It has been developed and tested with Godot 4.1, Steam VR, and a PICO 4 headset.

## Demo description

The demo has been created from a clean Godot project with the following project settings:

- Rendering: mobile (others will work, just with mobile in mind)
- Project settings to support VR:
    - General / XR / OpenXR: enabled
    - General / XR / Shaders: enabled

The project contains three scenes:
- Main: the top-level scene
- Player: the avatar with headset and controllers
- Brick: a rigid brick for building the wall

### Main

The main scene consists of a floor (StaticBody3D) with a collision shape and a mesh for the visual appearance. It has a script attached for setting up the demo and creating the wall. The wall is created in code; the bricks are instanced dynamically.

### Player

The player scene is a component used in the main scene. It contains the VR origin (XROrigin3D), and within that, the VR camera and two controllers. The controllers are associated with left/right hand in the inspector, and have a mesh attached for visuals.

The right controller has a "ray" mesh attached, and a script for pushing bricks. the script uses ray-tracing for detecting which brick (rigid body) is hit. When pulling the trigger, the hit object is given a kick (apply_impulse).

### Brick

The brick scene contains a re-usable rigid-body brick. Instances of this scene are created in the main script for building a wall.

## Notes

It appears that stacking too many rows of bricks will make the wall collapse. The physics engine will cause collisions between bricks that tumble the wall if too high. This can be resolved, but I left it for now.

## Initial and after thoughts on Godot

When playing with Godot a few years ago, I found it convenient for
quickly creating 3D-content, but was put off by the use of GDScript.
Having worked with C# and not exactly being a Python fan, this proprietary scripting language struck me as immature.

Re-evaluating the latest 4.1 version, once again, I found it a very convenient
development tool, and it feels more solid. The tings that made me most happy are:
- VR/XR-support, worked well for creating a demo
- Lightweight and small size, for sure when compared to a hog like Unity
- Fast compilation, debugging, and export of executables
- It's open source

WebXR-export gave me "SharedArrayBuffer" trouble, and from what I see on-line that is a common problem. I expect this to be resolved, as XR-support is a relatively new development and constantly moving. For WebXR development, I would still use three.js or the likes.

My (personal) preference for a different language remains, but I decided to go for the GDScript approach nevertheless.
C# is by now well-supported, but at the same time, I would like to keep the software lightweight and suitable for multiple platforms, including mobile.
