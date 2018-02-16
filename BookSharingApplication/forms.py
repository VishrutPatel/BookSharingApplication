from django import forms
from BookSharingApplication.models import CustomerProfile


class SignUpForm(forms.ModelForm):
        first_name = forms.CharField(max_length=30, required=True, help_text='Required.')
        last_name = forms.CharField(max_length=30, required=True, help_text='Required')
        email_id = forms.EmailField(max_length=254, required=True, help_text='Required.')
        addr1 = forms.CharField(max_length=255, required=True, help_text='Required')
        addr2 = forms.CharField(max_length=255, required=True, help_text='Required')
        city = forms.CharField(max_length=255, required=True, help_text='Required')
        state = forms.CharField(max_length=255, required=True, help_text='Required')
        zipcode = forms.CharField(max_length=255, required=True, help_text='Required')
        password = forms.PasswordInput()

        class Meta:
            model = CustomerProfile
            fields = ('first_name', 'last_name', 'email_id', 'addr1', 'addr2', 'city', 'state', 'zipcode', 'password',)
