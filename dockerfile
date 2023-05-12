FROM devopsedu/employee:LATEST
COPY ./website/www/html
ADD ./website/config.php
