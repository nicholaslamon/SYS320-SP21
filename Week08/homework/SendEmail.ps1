# Storyline: Send an email.
# Body of the email.
# A variable can have an underscore or any letter or number in it.
$msg = "Hello there."

# Write host = echo
write-host -BackgroundColor DarkRed -ForegroundColor White $msg


# Email From address
$email = "nicholas.lamon@mymail.champlain.edu"

# To address
$toEmail = "deployer@csi-web"

# Sending the email
Send-MailMessage -From $email -To $toEmail -Subject "A Greeting" -Body $msg -SmtpServer 192.168.6.71