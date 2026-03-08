#!/bin/bash
 sudo apt-get update 
 sudo apt-get install nginx -y
 sudo systemctl enable nginx 

echo "<h1> Hey there your web server is fully functional </h1>" | sudo tee var/www/html/index.html 
