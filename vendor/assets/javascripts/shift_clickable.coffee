#= require jquery

$ = jQuery
$.fn.shiftClickable = ->
  list   = $ this
  anchor = null
  anchorIndex = -> anchor?.index() ? 0
  checkboxSelector = 'input[type=checkbox]'

  shiftClick = (clicked) ->
    [ first, last ] = [ anchorIndex(), clicked.index() ]
    [ first, last ] = [ last, first ] if first > last

    checked = clicked.find(checkboxSelector).prop('checked')
    list.children('li')
      .slice(first, last + 1)
      .not(clicked)
      .find(checkboxSelector)
      .prop('checked', checked)
      .change()

  list.click (e) ->
    clicked = $ e.target
    if clicked.is 'li'
      clicked.find(checkboxSelector)
        .trigger $.Event('click', shiftKey: e.shiftKey)
    else
      clicked = clicked.closest 'li'

    # It seems WebKit triggers `change` before `click`, but I'm not too
    # confident that all browsers must trigger events in exactly the same way.
    # Defer setting the value to be sure the checkbox has its new value.
    window.setTimeout(
      ->
        shiftClick clicked if e.shiftKey
        anchor = clicked
      1)
