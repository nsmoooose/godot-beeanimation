This is a tiny project that shows a couple of bees flying around some
flowers. The frames generated by Godot will be stored in a directory
called 'frames' so it is possible to convert the content to an MP4
file.

Use this command in the frames directory to produce an MP4 file:

  ffmpeg -framerate 60 -i frame_%04d.png -c:v libx264 -pix_fmt yuv420p beeanimation.mp4

The MP4 file can then be used as a lock screen on Android devices.

Adjust the screensize in project settings to match your device.
