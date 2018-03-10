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
    $scope.logout = function(){
        $window.sessionStorage.removeItem("userEmail");
        window.location.replace("../index.html");
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

    $scope.checkAvailability = function(id){
        console.log(id);
    }
});

loginApp.controller('addBookController',function($scope,$window,$http){
    $scope.title = '';
    $scope.author = '';
    $scope.genre='';
    $scope.startDate = '';
    $scope.endDate = '';
    $scope.deliveryMode = '';
    $scope.bookAddedSuccessfully = false;
    $scope.addBook = function(){
        var bookData = {emailBook:$window.sessionStorage.getItem("userEmail"),titleBook:$scope.title,authorBook:$scope.author,genreBook:$scope.genre,startDateBook:$scope.startDate,endDateBook:$scope.endDate,deliveryModeBook:$scope.deliveryMode};
        $http({
            method: "POST",
            url: "../config/LenderData.php",
            data: bookData
        }).then(function(response){
            if(response.data.message=="True"){
                $scope.bookAddedSuccessfully = true;
            }
        },function(response){
        });
    }

});
loginApp.controller('lendedBooksController',function($scope,$window,$http){

});

loginApp.controller('borrowedBooksController',function($scope,$window,$http){

});
