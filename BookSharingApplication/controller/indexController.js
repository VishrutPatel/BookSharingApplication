var app = angular.module("mainApp",[]);

app.controller('indexController',function($scope,$window){
    $scope.email = '';
    $scope.firstName = '';
    $scope.lastName = '';
    $scope.addr1 = '';
    $scope.city = '';
    $scope.zipCode = '';
    $scope.password = '';
    $scope.retypePassword= '';
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
        if(allValid){
            var patternValid = true;
            if($scope.password!=$scope.retypePassword){
                $scope.passwordMismatchError = true;
                patternValid = false;
            }
            if($scope.zipCode.length!=5){
                $scope.zipCodeLengthError = true;
                patternValid = false;
            }
            if(patternValid){
                $window.location.href = "../BookSharingApplication/partials/landingPage.html"
            }
            else{
                $scope.formError = true;
            }
        }
        else{
            $scope.formError = true;
        }
    }
});