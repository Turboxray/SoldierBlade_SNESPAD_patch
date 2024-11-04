#Game Patch Instructions:

## PCEAS
This patch will add SNES pad support to the game. The right-shoulder button will change the ship speed (as well as normally pressing select).

PCEAS assembler is use to write code on top of the rom (if you're interested in see the code or seeing how it's done).
If you're feeling spicy or brave, you can give the batch converter(s) the correct rom and it will assemble the code directly into the rom. Done and done.
There are also some tools for removing rom headers for PCE games, as well as bit-swapping US roms (if you have an old rom dump).
These tools can also detect if your rom has either of these attributes in them, in case you don't know if your rom has these or not.

## IPS

For the less curious and straight-to-work folk, the IPS_patch folder contains the US and JP patches for Soldier Blade. They also require a headerless rom (hence the Tools folder if you need it).
A utility like Lunar_IPS can apply the patch for you (not included).


# SNES Controller to PCE port

Included in the repo is a document of how to wire a SNES controller to the PCE. It's just a wire setup (no ICs needed).
The document shows how to wire two controllers, but only need controller 1 for this game/patch.

I've labled what SNES gamepad pin needs to go to which PCE "pin" they map to by name. See document for ascii drawings.


# TAP (any)

The SNES controller wire up is not compatible with the TAP. It won't hurt it anything if used, but it won't read the SNES gamepads correctly.
Likewise, the game is patched for reading the SNES serial bus. It won't hurt anything by having a PCE pad plugged in-place of it, but also won't function correctly.


# Fash card usage

If you're loading from a flash device with a menu system, then you need to use a PCE pad and when the rom loads up: unplug the PCE pad and plug in the SNES pad.
Or make yourself a switch. As mentioned above, having the SNES gamepad plugged in when the menu system is polling for a PCE pad won't hurt anything; just won't function correctly.

# Other

 Unlike when you have a PCE gamepad in 6button mode, where some games wig out even if no button is pressed, having the SNES pad plugged for normal PCE games - if no buttons are pressed.. will look like no buttons are pressed.
 I.e. The resting state of the SNES gamepad and the resting state of a 2button PCE gamepad will look the same to the original PCE game software.

 
