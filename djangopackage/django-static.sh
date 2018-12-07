echo ' * Creating Static Folder..'
mkdir static
echo ' * Navigating into Static Folder..'
cd static
echo ' * Creating $2App Folder..'
mkdir $2App
echo ' * Navigating into $2App Folder..'
cd $2App
echo ' * Creating CSS Folder..'
mkdir css
echo ' * Navigating into CSS Folder..'
cd css
cat >| style.css << EOL
/*"""""""""""""""""SMILES""""""""""""""""""""""
""""""[]""""""""""""""""""""""""""""[]"""""""""
"""""""""[]""""""""""v1""""""""""[]""""""""""""
"""""""""""[][]""""""""""""""[][]""""""""""""""
"""""""""""""[][][][][][][][][]""""""""""""""""
"""""""""""""""""[][][][][]""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""*/
/* Fonts
  font-family: 'Roboto', sans-serif;
  font-family: 'Roboto Slab', serif;
  font-family: 'Pacifico', cursive;
  font-family: 'Press Start 2P', cursive;
  font-family: 'Finger Paint', cursive;
*/

/* Colors
  #AF0
  #8BF
  #D8A
  #FA8
  #DA8
  #AD0
  #250
*/

* {
  vertical-align: baseline;
  font-weight: inherit;
  font-family: 'Roboto', sans-serif;
  font-style: inherit;
  font-size: 100%;
  /* border: 1px red solid; */
  border: 0 none;
  outline: 0;
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}

a {
  color: #8BF;
  text-decoration: none;
}

#bot-nav {
  width: 960px;
  display: flex;
  flex-flow: row nowrap;
  justify-content: flex-end;
}

#container {
  width: 960px;
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  top-margin: 100px;
}

#dash-container {
  width: 960px;
  display: flex;
  flex-flow: column nowrap;
  justify-content: flex-start;
  top-margin: 100px;
}

.form-container {
  display: flex;
  flex-flow: column nowrap;
  align-content: flex-start;
  justify-content: flex-start;
}

.form-add-$2 {
  display: flex;
  flex-flow: column nowrap;
  height: 100%;
  width: 300px;
}

h5 {
  color: #8BF;
  font-size: 20px;
  font-family: 'Roboto', sans-serif;
  line-height: 40px;
}

h6 {
  color: #8BF;
  font-size: 25px;
  font-family: 'Roboto', sans-serif;
  line-height: 50px;
  margin-left: 25px;
  text-decoration: none;
}

.input-field {
  border: 1px solid #EEE;
  margin: 10px 0px;
  line-height: 25px;
  padding-left: 5px;
}

.input-btn {
  background-color: #EEE;
  line-height: 25px;
  margin-top: 15px;
  margin-bottom: 25px;
}

.errors {
  color: red;
  font-style: italic;
  font-size: .9em;
}

.nav-container {
  width: 960px;
  display: flex;
  flex-flow: row nowrap;
  justify-content: space-between;
}

.nav-item {
  margin-left: 10px;
  text-decoration: none;
  color: #8BF;
  transition: .5s;
}

.nav-item:hover {
  color: #D8A;
}

.add-btn {
  transition: .5s;
}

.add-btn:hover {
  color: #D8A;
}

.nav-list {
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  height: 50px;
  margin-right: 25px;
}

.small-container {
  width: 460px;
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
  padding: 25px 10px 25px 10px;
  border: 1px solid #EEE;
  margin-top: 25px;
}

.small-dash-container {
  width: 100%;
  display: flex;
  flex-flow: column nowrap;
  align-items: flex-start;
  padding: 25px;
  border: 1px solid #EEE;
  margin-top: 25px;
}

table {
  width: 100%;
  border: 1px solid #EEE;
  padding: 25px;
}

thead {
  width: 100%;
}

.hcell {
  padding: 5px 5px;
  border: 1px solid #EEE;
  text-align: left;
}

.tcell {
  padding: 2px 5px;
  text-align: left;
}

#top-nav {
  width: 100%;
  height: 50px;
  background-color: white;
  border-bottom: 1px solid #EEE;
  display: flex;
  flex-flow: row nowrap;
  justify-content: center;
}

#wrapper {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
}
EOL
echo ' * Navigating out of CSS Folder..'
cd ..
echo ' * Creating JavaScript Folder..'
mkdir javascript
echo ' * Creating Images Folder..'
mkdir images
echo ' * Navigating out of $2App Folder..'
cd ..
echo ' * Navigating out of Static Folder..'
cd ..
echo ' * Navigating out of $2App Folder..'
cd ..
echo ' * Navigating out of apps Folder..'
cd ..
echo ' * Navigating out of $1 Folder..'
cd ..
echo ' * Setup Complete'
