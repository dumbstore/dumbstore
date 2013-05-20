The Dumb Store
==============

The most inclusive mobile app platform in the world. Voice and text apps for [dumb phones](http://en.wikipedia.org/wiki/Feature_phone) (and smart phones, too!).

Usage
-----
Dumb apps can be used over voice and text. Call or text +1 646-666-3536 to access any of the apps available on the store.

### Voice Apps
To use a voice app, call the Dumb Store number. You will be prompted to enter the ID of the app you want to use followed by the pound key (#). For example, the L Train app's ID is "ltrain", so enter 587245 followed by the pound key. The app takes over from there.

### Text Apps
Send a text message to the Dumb Store number with the ID of the app you want to use followed by any additional information the app might be expecting from you. For example, the weather app's ID is "weather" and it expects additional text to tell it where to forecast the weather. To get the weather in New York, you would text `weather new york` to the Dumb Store number. The app takes over from there.

Contributing
------------
The Dumb Store uses the [GitHub's "Fork & Pull" Collaborative Model](https://help.github.com/articles/using-pull-requests) as its backbone.

### Fork and clone
1. [Fork](https://help.github.com/articles/fork-a-repo) the [Dumb Store](https://github.com/dumbstore/dumbstore) repository to your own account.

2. Clone the repository to your computer so that you can start writing code in it.

  ```
  $ git clone git@github.com:yourname/dumbstore.git
  ```

### Implement your app
1. Create a new file in the `apps/` folder. Use a name that reflects the nature of your app. Currently The Dumb Store only supports Ruby apps.

  ```
  $ touch apps/my-app.rb
  ```

2. A Dumb App is a Ruby class that inherits from `Dumbstore::App`. The name of the class must be a titlized verison of the file name. For example, `weather.rb` should have a class called `Weather`. A file called `local-listings.rb` should have a class called `LocalListings`.

  ```ruby
  class Weather < Dumbstore::App
      text_ID 'weather'
      def text params
        current_weather = WeatherApi.get_weather
        "<Response><Sms>The weather is #{current_weather}</Sms></Response>"
      end

      voice_ID 'weather'
      def voice params
        current_weather = WeatherApi.get_weather
        "<Response><Say>The weather is #{current_weather}</Say></Response>"
      end
  end
  ```

  An app can operate over text (SMS), voice, or both.

  To support SMS, give your app a text ID as shown above and implement a `text` method that takes a single argument and returns a string. The `text` method will be executed when a user sends a message to the store with your app's text ID. The argument passed to the method is a hash of [the original Twilio request](http://www.twilio.com/docs/api/twiml/sms/twilio_request). In the above example, `params['Body']` would hold the value of the user's text message minus the app ID. The method must return a valid [TwiML document](http://www.twilio.com/docs/api/twiml) in response to the user's text.

  Supporting voice is the same, except you give your app a voice ID and implement a `voice` method. Its [parameters](http://www.twilio.com/docs/api/twiml/twilio_request) are different.

  You can implement whatever kind of logic you want in the `text` and `voice` methods. See the apps in the [`apps/` folder](https://github.com/dumbstore/dumbstore/tree/master/apps) for reference.

  **Do not use a text or voice ID of an existing app.**

### Take out a pull request
1. Commit your changes to your local repository.

2. Push the changes to your GitHub account and take out a [pull request](https://help.github.com/articles/creating-a-pull-request).

3. Discuss the submission in the comments thread of the pull request. Once it's approved, it gets pushed to the store and made available to everyone!

Legal
-----
Copyright © 2013 Allison Burtch and Ramsey Nasser. Provided under the [MIT License](https://github.com/dumbstore/dumbstore/blob/master/LICENSE).