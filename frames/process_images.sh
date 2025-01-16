#!/bin/bash
ffmpeg -framerate 60 -i frame_%04d.png -c:v libx264 -pix_fmt yuv420p beeanimation.mp4
