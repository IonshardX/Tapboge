'use strict'

angular.module 'tapbogeApp'
.controller 'CharactersController', ($scope, $http, $location, Auth) ->

  $scope.init = ->
    $scope.getCharacters()
    $scope.character = Auth.getCurrentCharacter

  $scope.getCharacters = ->
    $http.get('/api/users/me/characters').success (data) ->
      $scope.characters = data

  $scope.createCharacter = (form) ->
    if form.$valid
      $http.post('/api/characters/', $scope.newCharacter)
      .success (character) ->
        $scope.characters.push(character)
        $scope.newCharacter = {}

  $scope.activateCharacter = (id) ->
    Auth.activateCharacter(id)
    .success ->
      $location.path '/game'

  $scope.init()
