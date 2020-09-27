# sound-desensitizer

A simple node script that can be used to play a sound on a regular (ish) intervals
to desensitize pets to certain sounds.

## Dependencies

`ffplay` is used to play the mp3 files

```
sudo apt install ffmpeg
```

## Install

```
sudo apt-get install curl && bash <(curl -s "https://raw.githubusercontent.com/gauntface/sound-desensitizer/master/install.sh?$(date +%s)")
```