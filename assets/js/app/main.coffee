app = angular.module("dizae", ["rsa"])

app.run ["keygen", (keygen) ->
  console.log (window.a = keygen())
]

app.controller "ChatCtrl", ["$scope", ($scope) ->
  buildMessage = (content) ->
    content: content
    owner: "mine"
    date: new Date()
    pending: true

  $scope.messages = []
  $scope.message = ""
  $scope.postMessage = ->
    $scope.messages.push(buildMessage($scope.message))
    $scope.message = ""
]
