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
    var email = {email:$window.sessionStorage.getItem("userEmail")};
    $http({
        method: "POST",
        url: "../config/getNotificationsCount.php",
        data: email
    }).then(function(response){
        $scope.count = response.data.count;
    },function(response){
    });
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
        .when('/notifications',{
            templateUrl: 'notification.html',
            controller : 'notificationController'
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
    $scope.bookData = null;
    $scope.checkAvailability = function(id){
        var bookIdentity = {bookId:id};
        $http({
            method: "POST",
            url: "../config/retrieveBookInfo.php",
            data: bookIdentity
        }).then(function(response){
            $scope.bookData = response.data.bookData;
        },function(response){
        });
    }
    $scope.requestSentSuccessfully = false;
    $scope.sendBorrowRequest = function(bookId){
        var borrowData = {bookIdentity:bookId,borrowerEmail: $window.sessionStorage.getItem("userEmail")};
        $http({
            method: "POST",
            url: "../config/BorrowRequest.php",
            data: borrowData
        }).then(function(response){
            console.log(response.data.message);
            if(response.data.message=="True"){
                $scope.requestSentSuccessfully = true;
            }
        },function(response){
        });
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
    var email = {email:$window.sessionStorage.getItem("userEmail")};
    $scope.noBooks = false;
    $http({
        method: "POST",
        url: "../config/getLentBooks.php",
        data: email
    }).then(function(response){
        if(response.data.message=="false"){
            $scope.noBooks = true;
        }
        else{
            $scope.lentBooks = response.data.message;
            console.log($scope.lentBooks);
        }
    },function(response){
    });
});

loginApp.controller('borrowedBooksController',function($scope,$window,$http){
    var email = {email:$window.sessionStorage.getItem("userEmail")};
    $scope.noBooks = false;
    $http({
        method: "POST",
        url: "../config/getBorrowedBooks.php",
        data: email
    }).then(function(response){
        if(response.data.message=="false"){
            $scope.noBooks = true;
        }
        else{
            $scope.borrowedBooks = response.data.message;
            console.log($scope.borrowedBooks);
        }
    },function(response){
    });
});

loginApp.controller('notificationController',function($scope,$window,$http,$route){
    var email = {email:$window.sessionStorage.getItem("userEmail")};
    $http({
        method: "POST",
        url: "../config/LenderNotifications.php",
        data: email
    }).then(function(response){
        $scope.notificationList = response.data.message;
    },function(response){
    });
    $scope.approveBorrowRequest = function(book_id,borrower_email){
        var approvedBookData = {bookId:book_id,borrowerEmail: borrower_email,lenderEmail:$window.sessionStorage.getItem("userEmail")};
        $http({
            method: "POST",
            url: "../config/approveRequest.php",
            data: approvedBookData
        }).then(function(response){
            $route.reload();
            $window.location.reload();
        },function(response){
        });
    }
});
