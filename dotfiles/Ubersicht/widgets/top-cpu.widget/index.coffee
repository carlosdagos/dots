command: "ps axro \"pid, %cpu, ucomm\" | awk 'FNR>1' | head -n 3 | awk '{ printf \"%5.1f%%,%s,%s\\n\", $2, $3, $1}'"

refreshFrequency: 2000

style: """
  z-index: -1
  bottom: 154px
  right: 0px
  color: rgba(#fff, .5)
  font-family: Consolas, Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

    &:after
      content: 'cpu'
      position: absolute
      right: 0
      top: -14px
      font-size: 10px

  td
    border: 0px solid #fff
    font-size: 26px
    font-weight: 100
    width: 120px
    max-width: 120px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    font-weight: 300
    background: rgba(#000, 0.0)

  .col2
    font-weight: 200
    background: rgba(#000, 0.0)

  .col3
    font-weight: 150
    background: rgba(#000, 0.0)

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: -> """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

