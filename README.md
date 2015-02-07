3dkits a spree webshop for 3d printer kits. go to 3dkits.be soon!


Showing why the open source framework ruby on rails is awesome.
Rails can be found here:
http://rubyonrails.org/

Ruby can be found here:
https://www.ruby-lang.org/en/


Best practices for programming in rails used by our community are explained here:
http://railscasts.com


As we're building we webshop we can use spree explained here:
http://railscasts.com/episodes/298-getting-started-with-spree?view=asciicast

Ok so now we had to run the following commands to generate our webshop.

```
rvm get stable
rvm osx-ssl-certs update all
rvm rubygems latest
gem install spree
gem install rails -v 4.2.0
```


For uploading images for our 3d printer products we use carrierwave explained here:
http://railscasts.com/episodes/253-carrierwave-file-uploads

```

rails g uploader image


```


Note to self to fix a rmagick error like this:

/Users/wschrep/.rvm/gems/ruby-2.1.0/gems/activesupport-4.2.0/lib/active_support/dependencies.rb:274:in `require': This installation of RMagick was configured with ImageMagick 6.8.7 but ImageMagick 6.8.9-8 is in use.

just do 

brew install imagemagick --build-from-source

and then gem install rmagick
and for spree fixing an error we do:

gem install rmagick -v 2.13.2





now we install and use mercury 

rails g mercury:install


rake mercury_engine:install:migrations

rails g mercury:install:images


