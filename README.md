Dumbstore
=========

An app store that hosts sms and voice apps for dumbphones.

Contributing
------------

1. [Fork](https://help.github.com/articles/fork-a-repo) the repository
2. Create a [new branch](https://github.com/dchelimsky/rspec/wiki/Topic-Branches) for your app
3. Add your app to the `apps/` folder
4. Commit
5. Take out a [pull request](https://help.github.com/articles/using-pull-requests) on `dumbstore/dumbstore`

Dumbapp Syntax
--------------

At the moment, Dumbapps are Ruby only. 

```ruby
class Weather < Dumbstore::App
  text_id 'weather'

  def text params
    fragments = [""]

```

Legal
-----
Copyright © 2013 Allison Burtch and Ramsey Nasser. Provided under the MIT License.