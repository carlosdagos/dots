command: "date +\"%a %d %b\""

refreshFrequency: 10000

render: (output) ->
  """
  <div class="cal">
    <span></span>
  </div>
  """

update: (output, el) ->
    $(".cal span:first-child", el).text("  #{output}")

style: """
  -webkit-font-smoothing: antialiased
  color: #DDD
  font: 12px "Fira Code"
  right: 70px
  top: 6px
"""
