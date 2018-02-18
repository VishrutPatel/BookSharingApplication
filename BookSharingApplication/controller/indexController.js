var app = angular.module("mainApp",[]);

app.controller('indexController',function($scope,$window){
    $scope.listOfStates = ["AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY",
        "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR",
        "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"]
    $scope.email = '';
    $scope.firstName = '';
    $scope.lastName = '';
    $scope.addr1 = '';
    $scope.city = '';
    $scope.zipCode = '';
    $scope.state = '';
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