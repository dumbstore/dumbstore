The Dumb Store
==============

The most inclusive mobile app platform in the world. Voice and text apps for [dumb phones](http://en.wikipedia.org/wiki/Feature_phone) (and smart phones, too!).

Usage
-----
Dumb apps can be used over voice and text. Call or text +1 646-666-3536 to access any of the apps available on the store.

### Voice Apps
To use a voice app, call the Dumb Store number. You will be prompted to enter the ID of the app you want to use followed by the pound key (#). For example, the Drone app's ID is "drone", so enter 37663 followed by the pound key. The app takes over from there.

### Text Apps
Send a text message to the Dumb Store number with the ID of the app you want to use followed by any additional information the app might be expecting from you. For example, the weather app's ID is "weather" and it expects additional text to tell it where to forecast the weather. To get the weather in Brooklyn, you would text `weather 11205` to the Dumb Store number. The app takes over from there.

Stability
----------
This is barely an alpha version :) Use at your own risk. Submit any bugs to the issue tracker.

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

2. A Dumb App is a Ruby class that inherits from `Dumbstore::App`. The name of the class must be a titlized version of the file name. For example, `weather.rb` should have a class called `Weather`. A file called `local-listings.rb` should have a class called `LocalListings`.

  ```ruby
  class Weather < Dumbstore::App
      author 'Ramsey Nasser'
      author_url 'http://nas.sr/'
      description 'My awesome weather app'

      text_id 'weather'
      def text params
        current_weather = WeatherApi.get_weather
        "<Response><Sms>The weather is #{current_weather}</Sms></Response>"
      end

      voice_id 'weather'
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

#### Testing

Testing your apps locally is currently very janky. For now, try `curl localhost:5000/text -d Body=APPNAMEHERE\ test\ text` after you've launched the server. We are actively working on a better local testing workflow.

#### Advanced

For functionality not exposed by our APIs, an authenticated Twilio client object is always available at `Dumbstore.twilio`. This will allow you to do anything [the Twilio gem](https://github.com/twilio/twilio-ruby) supports. `Dumbstore.twilio` is a reference to `@client.account`, so to send an SMS manually you could do this

```ruby
Dumbstore.twilio.sms.messages.create(
  :from => Dumbstore.phone_number,
  :to => '+16105557069',
  :body => 'Hey there!'
)
```

You also might want to skip the Dumbstore's automatic response mechanism when making more advanced apps. Return `nil` from a `text` or `voice` method to avoid responding.

```ruby
def voice params
  Dumbstore.twilio.sms.messages.create(
    :from => Dumbstore.phone_number,
    :to => 'params["From"]',
    :body => 'Responding to a call with a text!'
  )

  nil
end
```
### Take out a pull request
1. Commit your changes to your local repository.

2. Push the changes to your GitHub account and take out a [pull request](https://help.github.com/articles/creating-a-pull-request).

3. Discuss the submission in the comments thread of the pull request. Once it's approved, it gets pushed to the store and made available to everyone!


Legal
-----
Copyright © 2013 Allison Burtch and Ramsey Nasser. Provided under the [MIT License](https://github.com/dumbstore/dumbstore/blob/master/LICENSE).
