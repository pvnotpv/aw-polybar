# aw-polybar
ActivityWatch-Polybar : Module that shows the amount of time spent today and yesterday also with number of keyboard and mouse clicks.

Time spent:

<p float="left">
  <img src="https://github.com/pvnotpv/aw-polybar/blob/main/images/time.png?raw=true" width="440" />
</p>

Keyboard and Mouse clicks (resp):

<p float="left">
  <img src="https://github.com/pvnotpv/aw-polybar/blob/main/images/clicks.png?raw=true" width="440" />
</p>

(Alternates between the two at n time internal.)

---

Make sure you have activity-watch installed, running on default port 5600(if else make sure to change it in the script) and if you want to keep track of keystrokes and mouse clicks install aw-watcher-input and configure it.

https://github.com/ActivityWatch/aw-watcher-input

---

today.sh and yesterday.sh - Outputs today's and yesterday's time respectively.

clicknpress.sh - Yesterday's and today's keyboard and mouse clicks.

I didn't coimbine them into a single file for obvious reasons and if you want to display it like above image then create a script name activitywatch.sh or smtn and add this:

```
sudo pacman -S jq moreutils
```

```
todayout=$(bash /home/pv/.config/polybar/scripts/aw-polybar/today.sh)
yestout=$(bash /home/pv/.config/polybar/scripts/aw-polybar/yesterday.sh)
clickout=$(bash $HOME/.config/polybar/scripts/aw-polybar/clickpress.sh)

currentstats=$(jq -r '.status' $HOME/.config/polybar/scripts/stats.json)

if [[ $currentstats == 1 ]]; then
  echo "${todayout} | ${yestout}"
  jq '.status = 0' $HOME/.config/polybar/scripts/aw-polybar/stats.json | sponge $HOME/.config/polybar/scripts/aw-polybar/stats.json

else
  echo "${clickout}"
  jq '.status = 1' $HOME/.config/polybar/scripts/aw-polybar/stats.json | sponge $HOME/.config/polybar/scripts/aw-polybar/stats.json

fi

```

stats.json

```
{
  "status": 0
}
```

I'm not really sure if there's a better way to alternate between them(time and clicks) or does polybar has something like that.

---

Polybar config:

```
[module/awatch]
type = custom/script
internal = 30
exec = ~/.config/polybar/scripts/aw-polybar/activitywatch.sh
```
