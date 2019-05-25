# buiid binary file
# gox -osarch="linux/amd64" -output="deploy/bin/application"
gox -osarch="linux/amd64" -output="deploy/bin/application"
# enter dir deploy
cd deploy
chmod +x build.sh
# deploy elastic beanstalk
eb deploy  -l "Binary deploy"