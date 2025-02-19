FROM nginx:alpine3.21

# Set the working directory for copying files (optional)
WORKDIR /usr/share/nginx/html

# Clone the final project repo (replace <git-url> with the actual public Git repository URL)
# Clone it directly into the current directory
RUN apt-get update && apt-get install -y git \
    && git clone --depth 1 https://github.com/your-username/final-project.git .  # <-- Git URL here

# Now copy the built project (assuming the files are in the 'build' or 'dist' folder of the repo)
# You can copy them directly, removing the repo name from the path.
COPY ./final-project/build /usr/share/nginx/html