# Define the base image
# node:argon is the LTS of node docker image
FROM node:argon

# Set the working folder as the one that Jenkins will pull the updated codes
WORKDIR /var/lib/jenkins/jobs/node1/workspace

# Install app dependencies
COPY package.json /var/lib/jenkins/jobs/node1/workspace/
RUN npm install

# Bundle app to docker image
COPY . /var/lib/jenkins/jobs/node1/workspace

# Start the web port
EXPOSE 8081

# Run the web app
CMD ["npm", "start"]

# this is test code 1.3eqweqweqwe