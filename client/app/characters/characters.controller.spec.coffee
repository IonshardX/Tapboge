'use strict'

describe 'Controller: CharactersController', ->

  # load the controller's module
  beforeEach module 'tapbogeApp'
  CharactersController = undefined
  Character = undefined
  $scope = undefined
  $httpBackend = undefined
  testCharacters = [
      {name: "Character1", active: true},
      {name: "Character2"}
    ]

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, _$rootScope_, _$httpBackend_, _Character_) ->
    $scope = _$rootScope_.$new()
    CharactersController = $controller 'CharactersController',
      $scope: $scope
    $httpBackend = _$httpBackend_
    Character = _Character_

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'should request characters', ->
    $httpBackend.expectGET('/api/users/me/characters').respond testCharacters

    $httpBackend.flush()
    names = _.pluck($scope.characters, 'name')
    expect(names).toContain("Character1")
    expect(names).toContain("Character2")

  it 'should create a character', ->
    form = {$valid: true}
    newCharacter = {
      name: "New Character"
    }
    $scope.newCharacter = newCharacter
    $httpBackend.whenGET('/api/users/me/characters').respond testCharacters
    $httpBackend.expectPOST('/api/characters/').respond 201, newCharacter

    $scope.createCharacter(form)

    $httpBackend.flush()
    names = _.pluck($scope.characters, 'name')
    expect(names).toContain("New Character")
    expect($scope.newCharacter.name).toBe(undefined)

  it 'should fetch the current character', ->
    $httpBackend.whenGET('/api/users/me/characters').respond testCharacters
    $httpBackend.expectGET('/api/characters/active').respond testCharacters[0]

    Character.active()

    $httpBackend.flush()
