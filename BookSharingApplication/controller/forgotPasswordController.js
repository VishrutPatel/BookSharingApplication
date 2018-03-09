var forgotPasswordApp = angular.module("forgotPasswordApp",[]);

forgotPasswordApp.controller('forgotPasswordController',function($scope,$window,$http){
    $scope.forgotPasswordEmail = '';
    $scope.checkForgotPasswordValidation = function () {
        $scope.emailRequiredError = false;
        $scope.allTrue = false;
        var allValid = true;
        if($scope.forgotPasswordEmail.length==0){
            $scope.emailRequiredError = true;
            allValid = false;
        }
        if(allValid) {
            $scope.emailNotExists = false;
            var formData = {email: $scope.forgotPasswordEmail};
            $http({
                method: "POST",
                url: "../config/signup.php",
                data: formData
            }).then(function (response) {
                if (response.data.message == "Not Found") {
                    $scope.userNotExists = true;
                }
                else {
                    $scope.allTrue = true;
                }
            }, function (response) {
                console.log(response.data.message);
            });
        }
    }
    $scope.newPassword = '';
    $scope.resetPassword = '';
    $scope.secCode = '';
    $scope.checkResetPasswordValidation = function () {
        $scope.newPasswordNull = false;
        $scope.resetPasswordNull = false;
        $scope.passwordMismatchError = false;
        var valid = true;
        var nextValidation = true;
        if($scope.newPassword.length==0){
            $scope.newPasswordNull = true;
            valid = false;
        }
        if($scope.resetPassword.length==0){
            $scope.resetPasswordNull = true;
            valid = false;
        }
        if(valid){
            if($scope.newPassword!=$scope.resetPassword){
                $scope.passwordMismatchError = true;
                nextValidation = false;
            }
            if(nextValidation){

            }
        }

    }
});

