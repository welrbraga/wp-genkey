# Wordpress Gen Key

Secret key generator for Wordpress.

It's similar to [WordPress.org secret-key service](https://api.wordpress.org/secret-key/1.1/salt/) but under your control.

## Why should I use it?

Well, when you install Wordpress in your server, it's recomended you change eight security variables in your wp-config.php:

* AUTH_KEY
* SECURE_AUTH_KEY
* LOGGED_IN_KEY
* NONCE_KEY
* AUTH_SALT
* SECURE_AUTH_SALT
* LOGGED_IN_SALT
* NONCE_SALT

All of them have to be a long and random string to keep your instalation safest.

It's important to know that when you change those variables, all logged user are forced to login again, so change it frequently allow you to expire sessions.

## Requirement

Sorry guys but nowadays I have no creativity to simplify our lives so I use gpg tool as a random string generator.

So, you need to have gpg installed in your system to this tool run correctly in your system.

Don't worry, you won't use your keys nor generate one. We just use it to generate random sequences.

I promisse you change it in a future, ok!? But for now, use your best package manager to install gpg and go ahead.

```shell
sudo apt install gpg2
```

or

```shell
sudo yum install gpg2
```

## Installing and running

You just need to save wp-genkey.sh file in a Linux/Mac OS machine and change your executable bit permission.

Something like this is suficient:

```shell
sudo curl https://github.com/blob/master/genkey.sh -o /usr/local/bin/wp-genkey.sh
chmod +x wp-genkey.sh
```

### Running after install

Now that the script is saved under a directory in your PATH (/usr/local/bin) you just need to invoke it like any other:

```shell
wp-genkey.sh
```

## Running without installing

A amazing feature of Bash shell is that you can run scripts receveid by stdin. With this you can just get the script and run it without save any file in your machine.

If you want to run in a shoot you will prefer this command line that will run the last version available.

```shell
curl -sSL  https://github.com/welrbraga/wp-genkey/raw/main/wp-genkey.sh|bash -
```

## Using the keys (option 1)

Ok, a snnipet of a PHP file you be dumped in your screen with some comments and all variables set.

Copy the eight generated "define()" lines in your terminal; edit your wp-config.php overwriting the old lines pasting those new one. Just it!

Remember that if you cannot install this in your server, you have to download your wp-config.php, change it and upload it again, overwriting the original one.

## Using keys (option 2)

If you can access you server terminal, FTP, SSH, etc, It's a good idea to install this script there.

This way, you can schedule it in your crontab to regularly generate a changable file with that variables.

Sound good!? Let's go:
First, install the script in your server like instruction above;
Secondly, create a crontab file with this config

```crontab
34 3 * * * root /usr/local/bin/wp-genkey.sh >/var/www/wordpress/my_securitykeys.php
```

Some notes about this config:

```note
Change the schedule according your preference (It's scheduled to 3:34 AM).

Look at the path where we save the script (/usr/local/bin/wp-genkey.sh).

Do not forget to change the path where your Wordpress is installed (/var/www/wordpress/)
```

Now, edit you wp-config.php; comment out all the lines with that variables and near the last lines of the file add the line below, between the ABSPATH variable definition and your first use.

That is the new line to be added:

```php
require_once(ABSPATH . 'my_securitykeys.php');
```

Before change wp-config.php:

```php
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
?>
```

After change:

```php
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'my_securitykeys.php');
require_once(ABSPATH . 'wp-settings.php');
?>
```

Now, every day at 3:34AM (or on date/time you define) all those variables will be updated.
