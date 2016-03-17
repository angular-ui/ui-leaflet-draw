###globals inject###
describe 'leafletDrawEvents', ->
  beforeEach ->
    module('ui-leaflet')
    inject (_$compile_, _$rootScope_, _leafletData_, _leafletDrawEvents_) ->
      @$compile = _$compile_
      @$rootScope = _$rootScope_
      @leafletData = _leafletData_
      @subject = _leafletDrawEvents_

  it 'exists', ->
    @subject.should.be.ok

  it 'rootBroadcastName', ->
    @subject.rootBroadcastName.should.be.eql 'leafletDirectiveDraw'

  it 'lObjectType', ->
    @subject.lObjectType.should.be.eql 'draw'

  describe 'getAvailableEvents', ->
    it 'exists', ->
      @subject.getAvailableEvents.should.be.ok
    it 'returns expected', ->
      @subject.getAvailableEvents().should.be.eql [
        'created',
        'edited',
        'deleted',
        'drawstart',
        'drawstop',
        'editstart',
        'editstop',
        'deletestart',
        'deletestop'].map (n) -> 'draw:' + n

  it 'genDispatchEvent', ->
    @subject.genDispatchEvent.should.be.ok

  it 'bindEvents', ->
    @subject.bindEvents.should.be.ok

  it 'fire', ->
    @subject.fire.should.be.ok
