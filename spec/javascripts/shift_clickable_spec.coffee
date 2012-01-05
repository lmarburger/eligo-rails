#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->

  list = first = second = third = null
  shiftClickEvent = jQuery.Event 'click', shiftKey: true
  createCheckbox  = ->
    $('<input type="checkbox">').appendTo(
      $('<li/>').appendTo(list))

  deferExpect = (expectation) ->
    waits 1
    runs expectation

  afterEach  -> list.remove()
  beforeEach ->
    list   = $ '<ul/>'
    first  = createCheckbox()
    second = createCheckbox()
    third  = createCheckbox()
    list.shiftClickable()


  it 'simply checks checkboxes', ->
    first.trigger 'click'
    third.trigger 'click'

    deferExpect ->
      expect(first) .toBeChecked()
      expect(third) .toBeChecked()
      expect(second).not.toBeChecked()

  it 'checks checkboxes between last and shift-clicked checkboxes', ->
    first.trigger 'click'
    third.trigger shiftClickEvent

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .toBeChecked()

  it 'checks checkboxes below the shift-clicked checkbox', ->
    third.trigger 'click'
    first.trigger shiftClickEvent

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .toBeChecked()

  it 'sets a default anchor', ->
    second.trigger shiftClickEvent

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()

  it 'does not check checkboxes above the selected group', ->
    second.trigger 'click'
    third .trigger shiftClickEvent

    deferExpect ->
      expect(second).toBeChecked()
      expect(third) .toBeChecked()
      expect(first) .not.toBeChecked()

  it 'does not check checkboxes below the selected group', ->
    first .trigger 'click'
    second.trigger shiftClickEvent

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .not.toBeChecked()

  it 'unchecks checkboxes between last and shift-clicked checkboxes', ->
    group = [ third, second, first ]
    checkbox.trigger 'click' for checkbox in group
    third.trigger shiftClickEvent

    deferExpect ->
      expect(first) .not.toBeChecked()
      expect(second).not.toBeChecked()
      expect(third) .not.toBeChecked()
