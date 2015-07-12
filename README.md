## Overview

Using the Facebook Realtime API isn't easy since the documentation about the data you'll receive
and when you'll receive them is quite general and do not provides many examples.

This tool will listen `POST` requests then write their body in files. This way you can get all the
Facebook pushes from a page for further analysis.

You can start the tool with:

    bundle exec rackup config.ru

## In depth preparation

You have to create a [Facebook subscription][fb-subscription] in order to receive
[realtime][fb-realtime] pushes. Follow those step to do so.


### Start the server

Using the previous command, you should start the server and make it available on port 80.

### Create a Facebook application

To do this, you'll need a Facebook application. It is easy to create one from [here][fb-apps].

### Install the application to a page

Once your application is created, you have to install it to the page or user you want to receive
updates. You'll have to use the API, via the [Graph API Explorer][fb-explorer], to add the
application to the page. Get a page token for your application by following those steps:

1. Select your application in the topbar, where there is _Graph API Explorer_
2. Click on the _Get Token_ arrow
3. Select the name of the page you want to monitor

Once the access token field is filled, do the following request:

    POST /me/subscribed_apps

This will add the application to the page and will allow the application to receive page's updates.

### Configure the application

Still in the Graph API Explorer, we now have to set the endpoint that will receive the updates:

1. Select your application in the topbar, where there is _Graph API Explorer_
2. Click on the _Get Token_ arrow
3. Select the _Get App Token_ button

Once the access token is filled, do the following request:

    POST /<app-id>/subscriptions
      object:       page
      callback_url: http://<your-ip-address>/
      fields:       feed,conversations
      verify_token: realtime-explorer-token

You should have a successfull response here.

[fb-apps]: https://developers.facebook.com/apps/
[fb-explorer]: https://developers.facebook.com/tools/explorer/
[fb-realtime]: https://developers.facebook.com/docs/graph-api/real-time-updates/v2.4
[fb-subscription]: https://developers.facebook.com/docs/graph-api/reference/v2.4/app/subscriptions/
