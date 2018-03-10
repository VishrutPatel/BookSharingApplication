var app = angular.module("mainApp",[]);

app.controller('indexController',function($scope,$window,$http){
    $window.sessionStorage.setItem("userEmail",null);
    $window.sessionStorage.setItem("userPassword",null);
    $scope.listOfStates = ["AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY",
        "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR",
        "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"];
    $scope.searchFilter = ["author","title","genre"];
    $scope.email = '';
    $scope.firstName = '';
    $scope.lastName = '';
    $scope.addr1 = '';
    $scope.city = '';
    $scope.zipCode = '';
    $scope.state = '';
    $scope.password = '';
    $scope.retypePassword= '';
    $scope.showVerifCodeButton = true;
    $scope.secCode = '';
    $scope.checkValidation = function(){
        $scope.emailInvalid = false;
        $scope.firstNameInvalid = false;
        $scope.lastNameInvalid = false;
        $scope.addr1Invalid = false;
        $scope.cityInvalid = false;
        $scope.zipCodeInvalid = false;
        $scope.passwordInvalid = false;
        $scope.retypePasswordInvalid = false;
        $scope.formError = false;
        $scope.emailPatternInvalid = false;
        $scope.passwordMismatchError = false;
        $scope.zipCodeLengthError = false;
        $scope.userExists = false;
        $scope.inputSecCode = false;
        $scope.showSignUpButton = false;
        $scope.secCodeNullError = false;
        var allValid = true;
        if($scope.email.length==0){
            $scope.emailInvalid = true;
            allValid = false;
        }
        if($scope.firstName.length==0){
            $scope.firstNameInvalid = true;
            allValid = false;
        }
        if($scope.lastName.length==0){
            $scope.lastNameInvalid = true;
            allValid = false;
        }
        if($scope.addr1.length==0){
            $scope.addr1Invalid = true;
            allValid = false;
        }
        if($scope.city.length==0){
            $scope.cityInvalid = true;
            allValid = false;
        }
        if($scope.zipCode.length==0){
            $scope.zipCodeInvalid = true;
            allValid = false;
        }
        if($scope.password.length==0){
            $scope.passwordInvalid = true;
            allValid = false;
        }
        if($scope.retypePassword.length==0){
            $scope.retypePasswordInvalid = true;
            allValid = false;
        }
        if($scope.state.length==0 || $scope.state=="Select"){
            $scope.stateInvalid = true;
            allValid = false;
        }
        if(allValid){
            var patternValid = true;
            var regex = new RegExp("[a-zA-Z0-9]+@ncsu\.edu");
            if(!regex.test($scope.email)){
                $scope.emailPatternInvalid = true   ;
                patternValid = false;
            }
            if($scope.password!=$scope.retypePassword){
                $scope.passwordMismatchError = true;
                patternValid = false;
            }
            if($scope.zipCode.length!=5){
                $scope.zipCodeLengthError = true;
                patternValid = false;
            }
            if(patternValid){
                var formData = {email:$scope.email};
                $http({
                    method: "POST",
                    url: "config/signup.php",
                    data: formData
                }).then(function(response){
                    if(response.data.message=="Found"){
                        $scope.userExistsError = true;
                    }
                    else{
                        $scope.enterSecCode = true;
                        $scope.showSignUpButton = true;
                        $scope.showVerifCodeButton = false;
                        $scope.userExistsError = false;
                        var finalFormData = {
                            email: $scope.email,
                            firstName: $scope.firstName,
                            lastName: $scope.lastName,
                            addr1: $scope.addr1,
                            addr2: $scope.addr2,
                            city: $scope.city,
                            state: $scope.state,
                            zipCode: $scope.zipCode,
                            password: $scope.password
                        }
                        $http({
                            method: "POST",
                            url: "config/addSignUpData.php",
                            data: finalFormData
                        }).then(function (response) {

                            console.log(response.data.message);
                        }, function (response) {
                            console.log(response.data.message);
                        });
                    }
                },function(response){
                    console.log(response.data.message);
                });
            }
            else{
                $scope.formError = true;
            }
        }
        else{
            $scope.formError = true;
        }
    }
    $scope.openSecCode = function(){
        $window.open('../BookSharingApplication/partials/forgotPassword.html')
    }
    $scope.emailLogin = '';
    $scope.passwordLogin = '';
    $scope.checkValidationLogin = function(){
        $scope.emailLoginInvalid = false;
        $scope.passwordLoginInvalid  = false;
        $scope.loginFormError = false;
        var loginValid = true;
        if($scope.emailLogin.length == 0){
            $scope.emailLoginInvalid = true;
            loginValid = false;
        }
        if($scope.passwordLogin.length == 0){
            $scope.passwordLoginInvalid = true;
            loginValid = false;
        }
        $scope.loginError = false;
        if(loginValid){
            var loginFormData = {loginEmail:$scope.emailLogin, loginPassword:$scope.passwordLogin};
            $http({
                method: "POST",
                url: "config/login.php",
                data: loginFormData
            }).then(function(response){
                if(response.data.message=="Found"){
                    $window.sessionStorage.setItem("userEmail",$scope.emailLogin);
                    $window.sessionStorage.setItem("userPassword",$scope.passwordLogin);
                    $window.location.href = "partials/userPage.html";
                }
                else{
                    $scope.loginError = true;
                }
            },function(response){
                console.log(response.data.message);
            });


        }
        else{
            $scope.loginFormError = true;
        }
    }
    $scope.dropdownSelect = false;
    $scope.categorySelect = function(selectedCategory){
        $scope.dropdownSelect = true;
        $scope.showSelected = selectedCategory;
    }
    $scope.secCodeReq = false;
    $scope.secCodeLengthError = false;
    $scope.secCodeError = false;
    var validity = true;
    $scope.submitSignUpForm = function(){
        if($scope.secCode.length==0){
            $scope.secCodeReq = true;
            validity = false;
        }
        if($scope.secCode.length!=5){
            $scope.secCodeLengthError = true;
            validity = false;
        }
        if(validity){
            var secCodeData = {loginEmail:$scope.email,securitycode:$scope.secCode};
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
    }
    $scope.showBooks = function(){

        $http({
            method:"GET",
            url:"config/RetriveData.php"
        }).then(function(response){
            $scope.booksList = response.data;
        },function(response){
        });
    }
    $scope.checkAvailability = function (id) {
        if($window.sessionStorage.getItem("userEmail")=="null"){

        }
    }
});

app.filter('customBookFilter',function(){
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