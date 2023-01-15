# NFS Decal Helper

*Tested on Ubuntu 22.04*

### Prerequisites
- If using a Non-Windows OS, you must have WINE installed
- Python 3.5+ (specifically for `submodule.run`)

Steps:
1. Place PNG files in the `original` folder
    - These must be of dimensions: 2048x2048 / 2048x1024 / 1024x2048
	- It is recommended that these have an alpha channel
1. Run `./main.py` in the working directory
1. If successful, the `dds_textures` folder will contain the texture, mask, and thumbnail of all images in the `original` folder
    - If unsuccessful, there should be an error printed to the terminal
