#!/bin/bash

bin/rails db:migrate db:seed
bin/rails s -p 8080 -b 0.0.0.0
