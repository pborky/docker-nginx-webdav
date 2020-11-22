#!/bin/sh

HTPASSWD_FILE=/config/htpasswd

if [[ -n "${USERNAME}" ]] && [[ -n "${HASHED_PASSWORD}" ]]; then
	echo "${USERNAME}:${PASSWORD}" >> ${HTPASSWD_FILE}
	echo Created htpasswd file with given credentials.
elif [[ -n "${USERNAME}" ]] && [[ -n "${PASSWORD}" ]]; then
	htpasswd -B ${HTPASSWD_FILE} ${USERNAME} ${PASSWORD}
	echo Hashed given password and created htpasswd file.
elif [[ ! -e ${HTPASSWD_FILE} ]]; then
	echo Using no auth.
	sed -i 's%auth_basic           "Restricted";% %g'        /etc/nginx/conf.d/default.conf
	sed -i 's%auth_basic_user_file /etc/nginx/htpasswd;% %g' /etc/nginx/conf.d/default.conf
fi
