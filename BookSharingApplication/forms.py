from django import forms
from BookSharingApplication.models import CustomerProfile

STATE_CHOICES = (
        ('AL','Alabama'),
        ('AK','Alaska'),
        ('AZ', 'Arizona'),
        ('AR', 'Arkansas'),
        ('CA', 'California'),
        ('CO','Colorado'),
        ('CT', 'Connecticut'),
        ('DE', 'Delaware'),
        ('FL', 'Florida'),
        ('GA', 'Georgia'),
        ('HI', 'Hawaii'),
        ('ID', 'Idaho'),
        ('IL', 'Illinois'),
        ('IN', 'Indiana'),
        ('IA', 'Iowa'),
        ('KS', 'Kansas'),
        ('KY', 'Kentucky'),
        ('LA', 'Louisiana'),
        ('ME', 'Maine'),
        ('MD', 'Maryland'),
        ('MA', 'Massachusetts'),
        ('MI', 'Michigan'),
        ('MN', 'Minnesota'),
        ('MS', 'Mississippi'),
        ('MO', 'Missouri'),
        ('MT', 'Montana'),
        ('NE', 'Nebraska'),
        ('NV', 'Nevada'),
        ('NH', 'New Hampshire'),
        ('NJ', 'New Jersey'),
        ('NM', 'New Mexico'),
        ('NY', 'New York'),
        ('NC', 'North Carolina'),
        ('ND', 'North Dakota'),
        ('OH', 'Ohio'),
        ('OK', 'Oklahoma'),
        ('OR', 'Oregon'),
        ('PA', 'Pennsylvania'),
        ('RI', 'Rhode Island'),
        ('SC', 'South Carolina'),
        ('SD', 'South Dakota'),
        ('TN', 'Tennessee'),
        ('TX', 'Texas'),
        ('UT', 'Utah'),
        ('VT', 'Vermont'),
        ('VA', 'Virginia'),
        ('WA', 'Washington'),
        ('WV', 'West Virginia'),
        ('WI', 'Wisconsin'),
        ('WY', 'Wyoming'),
        ('GU', 'Guam'),
        ('PR', 'Puerto Rico'),
        ('VI', 'Virgin Islands')
    )


class SignUpForm(forms.ModelForm):
        first_name = forms.CharField(max_length=30, required=True, help_text='Required.')
        last_name = forms.CharField(max_length=30, required=True, help_text='Required')
        email_id = forms.EmailField(max_length=254, required=True, help_text='Required.')
        addr1 = forms.CharField(max_length=255, required=True, help_text='Required')
        addr2 = forms.CharField(max_length=255, required=True)
        city = forms.CharField(max_length=255, required=True, help_text='Required')
        state = forms.ChoiceField(choices=STATE_CHOICES, required=True)
        zipcode = forms.CharField(max_length=255, required=True, help_text='Required')
        password = forms.CharField(widget=forms.PasswordInput())
        Retype_password= forms.CharField(widget=forms.PasswordInput())

        class Meta:
            model = CustomerProfile
            fields = ('first_name', 'last_name', 'email_id', 'addr1', 'addr2', 'city', 'state', 'zipcode', 'password',)
