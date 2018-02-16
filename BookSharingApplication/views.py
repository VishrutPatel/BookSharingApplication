from django.shortcuts import render
from BookSharingApplication.forms import SignUpForm


def signupformshow(request):
    form = SignUpForm(request.POST or None)
    if form.is_valid():
        request.session['email'] = form.cleaned_data['email']
        request.session['first_name'] = form.cleaned_data['first_name']
        request.session['last_name'] = form.cleaned_data['last_name']
        request.session['addr1'] = form.cleaned_data['addr1']
        request.session['addr2'] = form.cleaned_data['addr2']
        request.session['city'] = form.cleaned_data['city']
        request.session['zipcode'] = form.cleaned_data['zipcode']
        request.session['state'] = form.cleaned_data['state']
        request.session['password'] = form.cleaned_data['password']

    context = {'form': form}
    return render(request, 'signup.html', context)



