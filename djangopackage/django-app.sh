echo ' * Calling django-admin to setup $2App..'
django-admin startapp $2App
echo ' * Navigating into $2App Folder..'
cd $2App
echo ' * Overwriting urls.py File..'
cat >| urls.py << EOL
from django.conf.urls import url
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('users/create', views.register),
    path('users', views.dash),
    path('join/<int:id>', views.join),
    path('login', views.login),
    path('logout', views.logout),
    path('$2s/new', views.$2_new),
    path('$2s/create', views.$2_create),
    path('$2s/<int:id>', views.$2s),
]
EOL
echo ' * Overwriting models.py File..'
cat >| models.py << EOL
from __future__ import unicode_literals
from django.db import models
from datetime import datetime
import re

# DATETIME
current_date_time = str(datetime.now())

# USER VALIDATION
class UserManager(models.Manager):
    def basic_validator(self, post_data):
        errors = {}
        #USERNAME VALIDATION
        if len(post_data['username']) < 1:
            errors['username'] = 'Username is required.'
        elif len(post_data['username']) < 3:
            errors['username'] = 'Username must be at least 3 characters.'
        elif User.objects.filter(username = post_data['username']):
            errors['username'] = 'Username is already taken, please choose another.'
        #NAME VALIDATION
        if len(post_data["name"]) < 1:
            errors['name'] = 'Name is required.'
        elif len(post_data["name"]) < 3:
            errors['name'] = 'Name must be at least 3 characters.'
        #PASSWORD VALIDATION
        if len(post_data['password']) < 1:
            errors['password'] = 'Password is required.'
        elif len(post_data['password']) < 8:
            errors['password'] = 'Password must be at least 8 characters.'
        if post_data['confirm_password'] != post_data['password']:
            errors['password'] = 'Passwords do not match.'
        return errors
    def login_validator(self, post_data):
        errors = {}
        #USERNAME VALIDATION
        if len(post_data["username"]) < 1:
            errors['username'] = 'Username is required.'
        elif not User.objects.filter(username = post_data['username']):
            errors['username'] = 'Username was not found.'
        #PASSWORD VALIDATION
        if len(post_data['password']) < 1:
            errors['password'] = 'Password is required.'
        return errors

# USER CLASS
class User(models.Model):
    username = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    password = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)
    objects = UserManager()
    def __repr__(self):
        return f'User: {self.id} {self.username}'

# $2 VALIDATION
class $2Manager(models.Manager):
    def $2_validator(self, post_data):
        errors = {}
        # DESTINATION VALIDATION
        if len(post_data['destination']) < 1:
            errors['destination'] = 'Destination is required.'
        # DESCRIPTION VALIDATION
        if len(post_data['description']) < 1:
            errors['description'] = 'Description is required.'
        # $2_FROM VALIDATION
        if not post_data["$2_from"]:
            errors["$2_from"] = "$2 from date is required."
        elif post_data['$2_from'] < current_date_time:
            errors["$2_from"] = "$2 from date must be in the future."
        # $2_TO VALIDATION
        if not post_data["$2_to"]:
            errors["$2_to"] = "$2 to date is required."
        elif not post_data['$2_to'] >= post_data['$2_from']:
            errors["$2_to"] = "$2 to date must not be before $2 from date."
        elif post_data['$2_from'] < current_date_time:
            errors["$2_from"] = "$2 to date must be in the future."
        return errors

# $2 CLASS
class $2(models.Model):
    destination = models.CharField(max_length=255)
    description = models.TextField(max_length=1000)
    $2_from = models.DateField()
    $2_to = models.DateField()
    $2s_users = models.ManyToManyField(User, related_name = "user_$2s")
    created_by = models.ForeignKey(User, related_name="$2s_created", on_delete = models.CASCADE)
    created_at = models.DateTimeField(auto_now_add = True)
    updated_at = models.DateTimeField(auto_now = True)
    objects = $2Manager()
    def __repr__(self):
return f'{self.id} {self.destination}'
EOL
echo ' * Overwriting views.py File..'
cat >| views.py << EOL
from django.shortcuts import render, HttpResponse, redirect
from .models import *
from django.contrib import messages
import bcrypt

# register NEW USER
def register(request):
    errors = User.objects.basic_validator(request.POST)
    if len(errors):
        for key, value in errors.items():
            messages.error(request, value)
        print(errors)
        return redirect('/')
    else:
        pass_hash = bcrypt.hashpw(request.POST['password'].encode('utf-8'), bcrypt.gensalt())
        user = User.objects.create(username = request.POST['username'], name = request.POST['name'], password = pass_hash.decode('utf-8'))
        request.session['id'] = user.id
        request.session['name'] = user.name
        return redirect('/users')

# USER DASHBOARD PAGE
def dash(request):
    try:
        all_$2s = $2.objects.exclude($2s_users = User.objects.get(id=request.session['id']))
        your_$2s = $2.objects.filter($2s_users = User.objects.get(id=request.session['id']))
        context = {
            'all_$2s': all_$2s,
            'your_$2s': your_$2s
        }
        return render(request, '$2/dash.html', context)
    except KeyError:
        return redirect('/')

# LOGIN / REGISTRATION PAGE
def index(request):
    return render(request, '$2/index.html')

# JOIN PROCESS
def join(request, id):
    user = User.objects.get(id=request.session['id'])
    $2 = $2.objects.get(id=id)
    user.user_$2s.add($2)
    user.save()
    return redirect('/users')

# LOGOUT PROCESS
def logout(request):
    request.session.clear()
    return redirect('/')

# LOGIN PROCESS
def login(request):
    errors = User.objects.login_validator(request.POST)
    if len(errors):
        for key, value in errors.items():
            messages.error(request, value)
        print(errors)
        return redirect('/')
    else:
        user = User.objects.get(username=request.POST['username'])
        if bcrypt.checkpw(request.POST['password'].encode('utf-8'), user.password.encode('utf-8')):
            request.session['id'] = user.id
            request.session['username'] = user.username
            return redirect('/users')
        else:
            messages.error(request, 'Incorrect password.')
            return redirect('/')

# $2 PAGE
def $2s(request, id):
    $2 = $2.objects.get(id=id)
    creator_id = $2.created_by.id
    user_list = User.objects.exclude(id = creator_id).filter(user_$2s = $2)
    print(user_list)
    context = {
        '$2': $2,
        'user_list': user_list
    }
    return render(request, '$2/$2.html', context)

# ADD $2 PAGE
def $2_new(request):
    return render(request, '$2/$2_new.html')

# ADD $2 PROCESS
def $2_create(request):
    errors = $2.objects.$2_validator(request.POST)
    if len(errors):
        for key, value in errors.items():
            messages.error(request, value)
        return redirect('/$2s/new')
    else:
        new_$2 = User.objects.get(id=request.session['id']).user_$2s.create(destination = request.POST['destination'], description = request.POST['description'], $2_from = request.POST['$2_from'], $2_to = request.POST['$2_to'], created_by = User.objects.get(id=request.session['id']))
        return redirect('/users')
EOL
echo ' * Calling ../../../djangopackage/django-templates.sh..'
. ../../../djangopackage/django-templates.sh
