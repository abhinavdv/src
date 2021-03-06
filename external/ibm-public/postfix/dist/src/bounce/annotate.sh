#!/bin/sh

cat <<'EOF'
#
# Do not edit this file. This file shows the default delivery status
# notification (DSN) messages that are built into Postfix.
#
# To change Postfix DSN messages, perhaps to add non-English text,
# follow instructions in the bounce(5) manual page.
#
EOF

# QUICK INSTRUCTIONS:
#
#-Edit a temporary copy of this file, and preview the result of $name
# expansions with "postconf -b temporary_file". If there are any
# problems, Postfix will log "warning" or "fatal" messages to the
# maillog file.
#
#-The template file can specify bounce message templates for
# failed mail, for delayed mail, for successful delivery, or for
# verbose delivery.  You don't have to specify all templates.
#
#-Each template starts with "template_name = <<EOF" and ends
# with a line that contains the word "EOF" only. You can change the
# word EOF if you like, but you can't do shell/perl/etc like things
# such as enclosing it in quotes (template_name = <<'EOF').
#
#-Each template consists of a few headers and message text. The
# headers control what the recipient sees as From: and Subject:, and
# what MIME information Postfix will generate.
#
#-Template message headers must not span multiple lines.
#
#-Template message headers must not contain main.cf $parameters.
#
#-Template message headers must contain ASCII characters only.
#
#-The template message text is not sent in Postmaster copies of
# delivery status notifications.
#
#-Template message text may contain main.cf $parameters. Some
# parameters have additional features as described below with the
# delayed mail message template.
#
#-Template message text may contain non-ASCII text. In that case you
# MUST change the character set value in the CHARSET: template header,
# otherwise Postfix will not use your template. You must specify a
# character set that is a superset of US-ASCII, because Postfix
# appends ASCII text after the message template when it sends a
# delivery status notification.
#
#-When previewing the result with "postconf -b temporary_file", be
# sure to pay particular attention to the time values that appear
# in the delayed mail notification text.
#
#-Once you're satisfied with the result, and once Postfix stops
# logging warning messages, copy the template to the Postfix
# configuration directory and specify in main.cf something like:
#
# /etc/postfix/main.cf:
#     bounce_template_file = $config_directory/bounce.cf
#
#EOF

IFS=
while read line; do
    case "$line" in
    failure_template*) cat <<'EOF'

#
# The failure template is used when mail is returned to the sender;
# either the destination rejected the message, or the destination
# could not be reached before the message expired in the queue.
#

EOF
	;;
    delay_template*) cat <<'EOF'

#
# The delay template is used when mail is delayed. Note a neat trick:
# the default template displays the delay_warning_time value as hours
# by appending the _hours suffix to the parameter name; it displays
# the maximal_queue_lifetime value as days by appending the _days
# suffix.
#
# Other suffixes are: _seconds, _minutes, _weeks. There are no other
# main.cf parameters that have this special behavior.
#
# You need to adjust these suffixes (and the surrounding text) if
# you have very different settings for these time parameters.
#

EOF
	;;
    success_template*) cat <<'EOF'

#
# The success template is used when mail is delivered to mailbox,
# when an alias or list is expanded, or when mail is delivered to a
# system that does not announce DSN support. It is an error to specify
# a Postmaster-Subject: here.
#

EOF
	;;
    verify_template*) cat <<'EOF'

#
# The verify template is used for address verification (sendmail -bv
# address...) or for verbose mail delivery (sendmail -v address...).
# It is an error to specify a Postmaster-Subject: here.
#

EOF
	;;
    esac
    echo "$line";
done
