var loginApp = angular.module("loginApp",[]);

loginApp.controller('loginController',function($scope,$window,$http){
    var userName = {userName:$window.sessionStorage.getItem("userEmail")};
    $http({
        method: "POST",
        url: "../config/retriveUserBooks.php",
        data: userName
    }).then(function(response){
        $scope.userName = response.data.message.toUpperCase();
    },function(response){
    });
});