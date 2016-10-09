command: """
    state=`osascript -e 'tell application "Spotify" to player state as string'`;
    artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
    album=`osascript -e 'tell application "Spotify" to album of current track as string'`;
    track=`osascript -e 'tell application "Spotify" to name of current track as string'`;
    duration=`osascript -e 'tell application "Spotify"
            set durSec to (duration of current track / 1000) as text
            set tM to (round (durSec / 60) rounding down) as text
            if length of ((durSec mod 60 div 1) as text) is greater than 1 then
                set tS to (durSec mod 60 div 1) as text
            else
                set tS to ("0" & (durSec mod 60 div 1)) as text
            end if
            set myTime to tM as text & ":" & tS as text
            end tell
            return myTime'`;
    position=`osascript -e 'tell application "Spotify"
            set pos to player position
            set nM to (round (pos / 60) rounding down) as text
            if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
                set nS to (round (pos mod 60) rounding down) as text
            else
                set nS to ("0" & (round (pos mod 60) rounding down)) as text
            end if
            set nowAt to nM as text & ":" & nS as text
            end tell
            return nowAt'`;

    echo -e "$state\n$artist\n$album\n$track\n$position / $duration";
"""

refreshFrequency: 1000 # ms

render: (output) ->
  """
  <div class="np">
    <span class="icon"></span>
    <span class="data"></span>
  </div>
  """

update: (output, el) ->
    [state, artist, album, track, pos] = output.split("\n")
    $(".np span.data", el).text("  #{artist} - #{album} - #{track} - (#{pos})")
    $icon = $(".np span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(state)}")

icon: (status) =>
    if status == "paused"
        "fa-pause-circle-o"
    else
        "fa-play-circle-o"

style: """
  -webkit-font-smoothing: antialiased
  text-align: center
  color: #DDD
  font: 12px "Fira Code"
  height: 16px
  left: 25%
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 50%
"""
