Dumbstore
=========

An app store that hosts sms and voice apps for dumbphones.

Contributing
------------
The Dumb Store uses the [GitHub's "Fork & Pull" Collaborative Model](https://help.github.com/articles/using-pull-requests) as its backbone. This allows for a transparent submission process built on established Open Source practices.

### Fork and clone
[Fork](https://help.github.com/articles/fork-a-repo) the [Dumb Store](https://github.com/dumbstore/dumbstore) repository to your own account. This will give you your own private copy of the Dumb Store on your account, named something like `github.com/yourname/dumbstore`.

Clone the repository to your computer so that you can start writing code in it.

    git clone git@github.com:yourname/dumbstore.git

### Implement your app
### Take out a pull request

1. Fork repository
2. Create topic branch
3. Create file in apps/ folder
4. Create class with same name as file subclassing Dumbstore::App
5. text_id, voice_id
6. def text, def voice
7. Commit
8. Push to git hub
9. Take out pull request
10. It gets reviewed and pushed to the cloud
11. There is no step 11

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
  end
end
```

Legal
-----
Copyright © 2013 Allison Burtch and Ramsey Nasser. Provided under the MIT License.