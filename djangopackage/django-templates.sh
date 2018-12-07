echo ' * Creating Templates Folder..'
mkdir templates
echo ' * Navigating into Templates Folder..'
cd templates
echo ' * Creating $2App Folder..'
mkdir $2App
echo ' * Navigating into $2App Folder..'
cd $2App
echo ' * Writing index.html File..'
cat >| index.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  {% load static %}
  <!-- The line above tells Django to be ready to listen for static files -->
  <link rel="stylesheet" href="{% static '$2/css/style.css' %}">
  <link href="https://fonts.googleapis.com/css?family=Finger+Paint|Pacifico|Press+Start+2P|Roboto|Roboto+Slab|Trade+Winds" rel="stylesheet">
  <title>$2 Buddy</title>
</head>
<body>
  <div id="wrapper">
    <nav id="top-nav">
      <nav class="nav-container">
        <h6>$2 Buddy</h6>
        <div class="nav-list">
          <div class="nav-item">

          </div>
        </div>
      </nav>
    </nav>
    <div id="container">
      <div class="small-container">
        <h5>Registration</h5>
        <!-- REGISTRATION FORM -->
        <form action="/users/create" method="post" class="form-container">
          {% csrf_token %}
          <input type="text" name="username" placeholder="Username" class="input-field">
          <input type="text" name="name" placeholder="Full Name" class="input-field">
          <input type="password" name="password" placeholder="Password" class="input-field">
          <input type="password" name="confirm_password" placeholder="Confirm Password" class="input-field">
          <input type="submit" value="register Account" class="input-btn">
        </form>
        {% if messages %}
          {% for message in messages %}
            <p class="errors"> {{ message }} </p>
          {% endfor %}
        {% endif %}
      </div>
      <div class="small-container">
        <h5>Login</h5>
        <!-- LOGIN FORM -->
        <form action="/login" method="post" class="form-container">
          {% csrf_token %}
          <input type="text" name="username" placeholder="Username" class="input-field">
          <input type="password" name="password" placeholder="Password" class="input-field">
          <input type="submit" value="Login" class="input-btn">
        </form>
        {% if messages %}
          {% for message in messages %}
            <p class="errors"> {{ message }} </p>
          {% endfor %}
        {% endif %}
      </div>
    </div>
  </div>
</body>
</html>
EOL
echo ' * Writing dash.html File..'
cat >| dash.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  {% load static %}
  <!-- The line above tells Django to be ready to listen for static files -->
  <link rel="stylesheet" href="{% static '$2/css/style.css' %}">
  <link href="https://fonts.googleapis.com/css?family=Finger+Paint|Pacifico|Press+Start+2P|Roboto|Roboto+Slab|Trade+Winds" rel="stylesheet">
  <title>$2 Buddy Dashboard</title>
</head>
<body>
  <div id="wrapper">
    <nav id="top-nav">
      <nav class="nav-container">
        <h6>$2 Buddy</h6>
        <div class="nav-list">
            <a href="/users" class="nav-item">Home</a>
            <a href="/logout" class="nav-item">Logout</a>
        </div>
      </nav>
    </nav>
    <div id="dash-container">
      <div class="small-dash-container">
        <h5>Your Trip Schedule</h5>
        <table>
          <thead>
            <th class="hcell">Destination</th>
            <th class="hcell">$2 Start Date</th>
            <th class="hcell">$2 End Date</th>
            <th class="hcell">$2</th>
          </thead>
          {% for $2 in your_$2s %}
          <tr>
            <td class="tcell"><a href="$2/{{ $2.id }}">{{$2.destination}}</a></td>
            <td class="tcell">{{ $2.$2_from }}</td>
            <td class="tcell">{{ $2.$2_to }}</td>
            <td class="tcell">{{ $2.description }}</td>
          </tr>
          {% endfor %}
        </table>
      </div>
      <div class="small-dash-container">
        <h5>Other User's $2s</h5>
        <table>
          <thead>
            <th class="hcell">Name</th>
            <th class="hcell">$2 Start Date</th>
            <th class="hcell">$2 End Date</th>
            <th class="hcell">$2</th>
            <th class="hcell">Join?</th>
          </thead>
          {% for $2 in all_$2s %}
          <tr>
            <td class="tcell">{{ $2.created_by.name }}</td>
            <td class="tcell"><a href="$2/{{ $2.id }}">{{ $2.destination }}</a></td>
            <td class="tcell">{{ $2.$2_from }}</td>
            <td class="tcell">{{ $2.$2_to }}</td>
            <td class="tcell"><a href="join/{{ $2.id }}">Join</a></td>
          </tr>
          {% endfor %}
        </table>
      </div>
    </div>
    <div id="bot-nav">
      <a href="/$2_new" class="nav-item nav-list" class="add-btn">Add $2 $2</a>
    </div>
  </div>
</body>
</html>
EOL
echo ' * Writing $2.html File..'
cat >| $2.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  {% load static %}
  <link rel="stylesheet" href="{% static '$2/css/style.css' %}">
  <link href="https://fonts.googleapis.com/css?family=Finger+Paint|Pacifico|Press+Start+2P|Roboto|Roboto+Slab|Trade+Winds" rel="stylesheet">
  <title>$2 Buddy $2</title>
</head>
<body>
  <div id="wrapper">
    <nav id="top-nav">
      <nav class="nav-container">
        <h6>$2 Buddy</h6>
        <div class="nav-list">
          <div class="nav-item">
            <a href="/users" class="nav-item">Home</a>
            <a href="/logout" class="nav-item">Logout</a>
          </div>
        </div>
      </nav>
    </nav>
    <div id="container">
      <div class="small-container">
        <h5>{{ $2.destination }}</h5>
        <p>Created by: {{ $2.created_by.name }}</p>
        <p>$2 Start Date: {{ $2.$2_from }}</p>
        <p>$2 End Date: {{ $2.$2_to }}</p>
        <p>$2: {{ $2.description }}</p>
      </div>
      <div class="small-container">
        <h5>Other users joining the trip</h5>
        {% for user in user_list %}
        <p>{{user.name}}</p>
        {% endfor %}
      </div>
    </div>
  </div>
</body>
</html>
EOL
echo ' * Writing $2.html File..'
cat >| $2_new.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  {% load static %}
  <link rel="stylesheet" href="{% static '$2/css/style.css' %}">
  <link href="https://fonts.googleapis.com/css?family=Finger+Paint|Pacifico|Press+Start+2P|Roboto|Roboto+Slab|Trade+Winds" rel="stylesheet">
  <title>$2 Buddy Add $2</title>
</head>
<body>
  <div id="wrapper">
    <nav id="top-nav">
      <nav class="nav-container">
        <h6>$2 Buddy</h6>
        <div class="nav-list">
            <a href="/users" class="nav-item">Home</a>
            <a href="/logout" class="nav-item">Logout</a>
        </div>
      </nav>
    </nav>
    <div id="dash-container">
      <div class="small-dash-container">
        <!-- REGISTRATION FORM -->
        <form action="/$2s/create" class="form-add-$2" method="post">
          {% csrf_token %}
          <input type="text" name="destination" placeholder="Destination" class="input-field">
          <input type="textarea" name="description" placeholder="Description" class="input-field">
          <input type="date" name="$2_from" placeholder="$2 Date From" class="input-field">
          <input type="date" name="$2_to" placeholder="$2 Date To" class="input-field">
          <input type="submit" value="Add" class="input-btn">
          {% if messages %}
            {% for message in messages %}
              <p class="errors"> {{ message }} </p>
            {% endfor %}
          {% endif %}
        </form>
      </div>
    </div>
    <div id="bot-nav">
      <a href="/users" class="nav-item nav-list" id="add-btn">Back</a>
    </div>
  </div>
</body>
</html>
EOL
echo ' * Navigating out of $2App Folder..'
cd ..
echo ' * Navigating out of Templates Folder..'
cd ..
echo ' * Calling ../../../djangopackage/django-static.sh..'
. ../../../djangopackage/django-static.sh
