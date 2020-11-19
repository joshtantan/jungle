# Jungle

Jungle is an eCommerce web application for a basic online store built with Ruby on Rails including user and admin login, user registration, and credit card checkout via the Stripe API.

## Final Product

### Cart Adding and Editing
!["Screengrab of cart adding and editing"]() 

### Cart Checkout with Stripe
!["Screengrab of cart checkout with Stripe"]() 

### Admin Products and Categories with Required Login
!["Screengrab of admin products and categories with required login"]() 

## Dependencies

- rails 4.2.6
- pg
- stripe
- money-rails
- sass-rails
- bootstrap-sass
- jquery-rails
- bcrypt
- dotenv-rails
## Runtime Usage

> All commands are run from the project root directory
1. Install all dependencies before first use
```shell
$ bundle i
```
2. Create and fill in your own `.env` file based on `.env.example`. Create a Stripe account and obtain your keys there if necessary.
3. Start the web server
> If running on host
```shell
$ rails s
```
> If running on VM
```shell
$ rails s -b 0.0.0.0
```

## Payment Simulation Details

Use the ff credit card details to demo payment:
- Number: `4242 4242 4242 4242`
- Expiry Date: `<any_future_date>`
- CSV: `<any_3_digits>`
