# README

About: Dividend Investment Tool is a web application to help users track their dividends and show them how much they should expect to make for the year. The web application uses an api to make requests and retrieve stock info based on a ticker and then calculates the dividend for each stock by multiplying that by the number of shares the user has.

Setup: In order to use the application, you will need to first go to https://www.alphavantage.co/ and create a free api key.

Next, when opening the app you will need to run bundle install in the terminal to have all the necessary gems required to run the app.

You will then need to create a .env file in root of the project and create a new environment variable called API_KEY and set it to your api key that you recieved from alphavantage.

Setting up the facebook authentication:

1) Head to https://developers.facebook.com/
2) click my apps and then create app
3) Select consumer as we are just using the facebook login functionality
4) Add the name of the app in the app display name
5) Hit dashboard and then scroll down and add facebook login
6) select web and add the url. In this case it will be https://localhost:3000/
7) under products select settings under the facebook login
8) in the valid OAuth redirect uris add https://localhost:3000/auth/facebook/callback
9) click settings and then basic and you should see the app id and app secret.
10) Head to your env file and make a FACEBOOK_APP_ID, FACEBOOK_APP_SECRET and set those to the app id and secret.

Running the App: In order to run the app you will need to run rails s to start up the rails server.

Once done, you should be able to see the login page in which you can either sign up or login.

Enjoy!
