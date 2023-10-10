#!/bin/bash

# Generate new random strings to use as Wordpress secret keys
# It's similar to what you find in:
#  https://api.wordpress.org/secret-key/1.1/salt/
# But it's under your control.
#

# Welington R Braga - 2023-08

V="2023.10.10-2"

KEYS=(
    'AUTH_KEY'
    'SECURE_AUTH_KEY'
    'LOGGED_IN_KEY'
    'NONCE_KEY'
    'AUTH_SALT'
    'SECURE_AUTH_SALT'
    'LOGGED_IN_SALT'
    'NONCE_SALT'
    )

cat <<EoM
<?php
/**
 * Random strings generated by wordpress-genkey (v. $V) to use as Wordpress
 * secret keys.
 * 
 * It's similar to what Wordpress API returns, but it's under your control.
 *    https://api.wordpress.org/secret-key/1.1/salt/
 *
 * Instructions and downloads here:
 *    https://github.com/welrbraga/wp-genkey
 *
 * File created at $(LC_TIME=C date)
**/
EoM
for KEY in ${KEYS[@]}; do
    KEY_SPACES="'$KEY',"
    __RANDOM__=$(dd if=/dev/urandom count=78 2>/dev/null | tr -dc '[:alnum:]' | cut -c -78)
    printf "define( %-19s '%s' );\n" $KEY_SPACES $__RANDOM__
done
echo '?>'
