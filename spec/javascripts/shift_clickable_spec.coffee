#= require jquery
#= require jasmine-jquery
#= require sinon
#= require jasmine-sinon

describe 'shiftClickable()', ->

  deferExpect = (expectation) ->
    waits 1
    runs expectation

  list = checkID = first = second = third = null
  afterEach  -> list.remove()
  beforeEach ->
    list    = $ '<ul/>'
    checkID = 1
    first   = createCheckbox()
    second  = createCheckbox()
    third   = createCheckbox()
    list.shiftClickable()

  shiftClickEvent = -> jQuery.Event 'click', shiftKey: true
  createCheckbox  = ->
    $('<input type="checkbox">')
      .attr('id', checkID++)
      .appendTo($('<li/>').appendTo(list))


  it 'simply checks checkboxes', ->
    first.trigger 'click'
    third.trigger 'click'

    deferExpect ->
      expect(first) .toBeChecked()
      expect(third) .toBeChecked()
      expect(second).not.toBeChecked()

  it 'checks checkboxes between last and shift-clicked checkboxes', ->
    first.trigger 'click'
    third.trigger shiftClickEvent()

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .toBeChecked()

  it 'checks checkboxes below the shift-clicked checkbox', ->
    third.trigger 'click'
    first.trigger shiftClickEvent()

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .toBeChecked()

  it 'sets a default anchor', ->
    second.trigger shiftClickEvent()

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()

  it 'does not check checkboxes above the selected group', ->
    second.trigger 'click'
    third .trigger shiftClickEvent()

    deferExpect ->
      expect(second).toBeChecked()
      expect(third) .toBeChecked()
      expect(first) .not.toBeChecked()

  it 'does not check checkboxes below the selected group', ->
    first .trigger 'click'
    second.trigger shiftClickEvent()

    deferExpect ->
      expect(first) .toBeChecked()
      expect(second).toBeChecked()
      expect(third) .not.toBeChecked()

  it 'unchecks checkboxes between last and shift-clicked checkboxes', ->
    group = [ third, second, first ]
    checkbox.trigger 'click' for checkbox in group
    third.trigger shiftClickEvent()

    deferExpect ->
      expect(first) .not.toBeChecked()
      expect(second).not.toBeChecked()
      expect(third) .not.toBeChecked()

  it 'handles shift-clicks on appended checkboxes', ->
    late = createCheckbox()
    second.trigger 'click'
    late  .trigger shiftClickEvent()

    deferExpect ->
      expect(second).toBeChecked()
      expect(third) .toBeChecked()
      expect(late)  .toBeChecked()

  it 'checks appended checkboxes', ->
    firstLate  = createCheckbox()
    secondLate = createCheckbox()
    second    .trigger 'click'
    secondLate.trigger shiftClickEvent()

    deferExpect ->
      expect(second)    .toBeChecked()
      expect(third)     .toBeChecked()
      expect(firstLate) .toBeChecked()
      expect(secondLate).toBeChecked()

  it 'adjusts anchor to account for inserted checkboxes', ->
    firstLate  = createCheckbox()
    secondLate = createCheckbox()

    second.trigger 'click'
    deferExpect ->
      firstLate.add(secondLate).closest('li')
        .insertBefore(second.closest('li'))

      first.trigger shiftClickEvent()

    deferExpect ->
      expect(first)     .toBeChecked()
      expect(firstLate) .toBeChecked()
      expect(secondLate).toBeChecked()
      expect(second)    .toBeChecked()
