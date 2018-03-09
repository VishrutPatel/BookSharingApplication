var loginApp = angular.module("loginApp",['ngRoute']);

loginApp.controller('loginController',function($scope,$window,$http){
    $scope.getUserName = function() {
        var user = {userName: $window.sessionStorage.getItem("userEmail")};
        $http({
            method: "POST",
            url: "../config/retriveUserBooks.php",
            data: user
        }).then(function (response) {
            $scope.userName = response.data.message.toUpperCase();
        }, function (response) {
        });
    }
});

loginApp.filter('customBookFilter',function(){
    return function (input, option) {
        if (!option.type || !option.term) {
            return input;
        }
        var result = [];
        angular.forEach(input,function (val, key) {
            if(val[option.type].toLowerCase().indexOf(option.term.toLowerCase())>-1){
                result.push(val);
            }
        })
        return result;
    }
});


// configure our routes
loginApp.config(function($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl : 'basicPage.html',
            controller  : 'basicController'
        })
        .when('/addBook', {
            templateUrl : 'addBook.html',
            controller  : 'addBookController'
        })
        .when('/lendedBooks', {
            templateUrl : 'lendedBooks.html',
            controller  : 'lendedBooksController'
        })
        .when('/borrowedBooks', {
            templateUrl : 'borrowedBooks.html',
            controller  : 'borrowedBooksController'
        })
        .otherwise({
            redirectTo: '/'
        });
});

loginApp.controller('basicController',function($scope,$window,$http){
    $scope.searchFilter = ["author", "title", "genre"];
    $scope.dropdownSelect = false;
    $scope.categorySelect = function(selectedCategory){
        $scope.dropdownSelect = true;
        $scope.showSelected = selectedCategory;
    }
    $http({
        method:"GET",
        url:"../config/RetriveData.php"
    }).then(function(response){
        $scope.booksList = response.data;
    },function(response){
    });
});

loginApp.controller('addBookController',function($scope,$window,$http){
    $scope.addBook = function(){
        var bookData = {title:$scope.title,author:$scope.author,genre:$scope.genre,startDate:$scope.startDate,endDate:$scope.endDate};
        $http({
            method: "POST",
            url: "config/checkSecCode.php",
            data: secCodeData
        }).then(function(response){
            if(response.data.message=="True"){
                $window.sessionStorage.setItem("userEmail",$scope.email);
                $window.location.href = "partials/userPage.html";
            }
            else{
                $scope.secCodeError = true;
            }
        },function(response){
            console.log(response.data.message);
        });
    }

});
loginApp.controller('lendedBooksController',function($scope,$window,$http){

});

loginApp.controller('borrowedBooksController',function($scope,$window,$http){

});
