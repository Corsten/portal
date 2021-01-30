#!/bin/bash

QUEUE=* bin/rails resque:workers
