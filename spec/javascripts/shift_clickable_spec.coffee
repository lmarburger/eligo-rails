#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->

  body = null
  beforeEach -> body = $ 'body'

  shiftClickEvent = jQuery.Event 'click', shiftKey: true
  createCheckbox  = => $('<input type="checkbox">').appendTo(body)

  it 'sets the default anchor above the first checkbox', ->
    first = createCheckbox()
    last  = createCheckbox()

    $(':checkbox').shiftClickable()
    last.trigger shiftClickEvent

    expect(first).toBeChecked()
    expect(last) .toBeChecked()
