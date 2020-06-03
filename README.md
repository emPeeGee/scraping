# Scraping
Ruby app which enter a web interface <a href="https://demo.bendigobank.com.au/banking/sign_in">demo.bendigobank.com</a> 
and extract necessary information(accounts and their transactions) and return in JSON format. 

<h3>You can have problems with webdriver</h3>
<p>For this, read <a href="https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver">this</a></p>

<hr>

<h3>How to use?</h3>

<ul>
    <li>First of all : <code>git clone https://github.com/emPeeGee/scraping.git</code></li>
    <li>Install Bundler : <code>gem install bundle</code></li>
    <li>Install gems with bundler : <code>bundle install</code></li>
    <li>Run app : <code>ruby app.rb</code></li>
</ul>

<hr>

<h3>Result of the app</h3>
<p>App will print in terminal JSON of the accounts and transactions and will create "accounts.json" with output</p>

