Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

The app can receive faxes, which takes about 1 minute.

To test fax receiving function, use ngrok:
  Find the local portal that hosts the website. Example: "localhost:3000"
  Open a new terminal, type: "ngrok http LOCAL_HOST_PORTAL_NUMBER". Example: "ngrok http 3000"
  Click on the "Visit this site" button of the server site
  Get the ngrok webhook. Example: https://348d-124-39-32-242.jp.ngrok.io/

Change the Inbound Parse Webhook on Sendgrid and call the method "submit_result"
  Access https://app.sendgrid.com/settings/parse
  Delete the existing webhook
  Add new webhook
    Development: webhook configured to ngrok.
      Example:
        domain: healthway.live
        url: https://348d-124-39-32-242.jp.ngrok.io/submit_result
    Production: webhook configured to healthway.live
      Example:
        domain: healthway.live
        url: https://healthway.live/submit_result

Sendgrid has been incorporated into the app, hardcoded to one user for demontration purposes.
To change the user receiving the result attachment:
  Go to health_checks_controller.rb
  In the method submit_result, change the first_name to the desired user.
    Example: health_check = User.find_by(first_name: "oanh").health_checks.last
