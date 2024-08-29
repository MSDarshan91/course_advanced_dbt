# Bingeflix Docs
This file contains doumentation for Bingeflix data sources.

## Users
This section contains documentation from the Bingeflix Users table.

{% docs bingeflix_table_users %}
This table stores information about Bingeflix users, including user IDs, usernames, email addresses, subscription start dates, and other relevant user details
{% enddocs %}

{% docs bingeflix_column_user_id %}
The unique identifier of the user.
{% enddocs %}

{% docs bingeflix_column_created_at_user %}
Timestamp when the user account was created.
{% enddocs %}

{% docs bingeflix_column_phone_number %}
Phone number associated with the user.
{% enddocs %}

{% docs bingeflix_column_deleted_at %}
Timestamp when the user account was deleted. (This is NULL if the account is not deleted.)
{% enddocs %}

{% docs bingeflix_column_username %}
The username used for login
{% enddocs %}

{% docs bingeflix_column_name %}
Full name of the user.
{% enddocs %}

{% docs bingeflix_column_sex %}
Gender of the user.
{% enddocs %}

{% docs bingeflix_column_email %}
Email address of the user.
{% enddocs %}

{% docs bingeflix_column_birthdate %}
Date of birth of the user.
{% enddocs %}

{% docs bingeflix_column_region %}
Region of the user, usually referring to a state or province.
{% enddocs %}

{% docs bingeflix_column_country %}
Country of the user.
{% enddocs %}

## Ads
This section contains documentation from the Bingeflix Ads table.

{% docs bingeflix_table_ads %}
The table contains data related to ad campaigns, including financial metrics like spend, CPM, and performance metrics like CTR.
{% enddocs %}

{% docs bingeflix_column_date %}
The date when the ad campaign data was served.
{% enddocs %}

{% docs bingeflix_column_campaign_id %}
Unique identifier for the ad campaign.
{% enddocs %}

{% docs bingeflix_column_spend %}
Total amount spent on the ad campaign.
{% enddocs %}

{% docs bingeflix_column_cpm %}
The average cost per 1,000 impressions.
{% enddocs %}

{% docs bingeflix_column_ctr %}
The average click-through rate on ads served, calculated as the number of clicks divided by the number of impressions.
{% enddocs %}

## Events
This section contains documentation from the Bingeflix Events table.


{% docs bingeflix_table_events %}
This table captures user interactions and events within the platform, such as session activities and specific user actions.
{% enddocs %}

{% docs bingeflix_column_session_id %}
Unique identifier for the session in which the event occurred.
{% enddocs %}

{% docs bingeflix_column_created_at_event %}
Timestamp when the event was created.
{% enddocs %}

{% docs bingeflix_column_event_name %}
Name of the event that occurred.
{% enddocs %}

{% docs bingeflix_column_event_id %}
Unique identifier for the event.
{% enddocs %}

## Subscriptions
This section contains documentation from the Bingeflix Subscriptions table.


{% docs bingeflix_table_subscriptions %}
This table contains subscription-related information, such as subscription plan IDs, subscription start dates, renewal dates, billing information, and any other relevant subscription details.
{% enddocs %}

{% docs bingeflix_column_subscription_starts_at %}
Timestamp indicating when the subscription started.
{% enddocs %}

{% docs bingeflix_column_subscription_ends_at %}
Timestamp indicating when the subscription ended or is set to expire. The value is NULL if the subscription plan has auto-renew turned on/does not have a defined end date.
{% enddocs %}

{% docs bingeflix_column_subscription_id %}
Unique identifier for the subscription.
{% enddocs %}


## Subscription Plans
This section contains documentation from the Bingeflix Subscription Plans table.


{% docs bingeflix_table_subscription_plans %}
This table contains information about the subscription plans available at Bingeflix
{% enddocs %}

{% docs bingeflix_column_subscription_plan_id %}
Unique identifier for the subscription plan.
{% enddocs %}

{% docs bingeflix_column_subscription_plan_name %}
Name of the subscription plan (e.g., Basic, Premium).
{% enddocs %}

{% docs bingeflix_column_subscription_plan_pricing %}
The price of the subscription plan per payment period.
{% enddocs %}

{% docs bingeflix_column_subscription_plan_payment_period %}
The payment period for the plan (e.g., monthly, annually).
{% enddocs %}
