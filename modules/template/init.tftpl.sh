#!/bin/bash
sudo apt update -y && sudo apt install -y nginx
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<body>
<h1>Hello this is ${name}</h1>

<p>
%{ if index == 1 ~}
This is the first one :))))))))
%{ else ~}
This is not the first one :(((
%{ endif ~}
</p>
</body>
</html>
EOF
