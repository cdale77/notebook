FROM cdale77/docker-elixir-base

# App-specific dependencies.
RUN apt-get install -y postgresql-client

# Set up app directory
RUN mkdir /var/app
WORKDIR /var/app

# Set the default version
ARG VERSION=0.0.1

# Copy the compiled release and extract
COPY /rel/notebook/releases/${VERSION}/notebook.tar.gz /var/app/notebook.tar.gz
COPY wait-for-it.sh /var/app/wait-for-it.sh
RUN tar -xvzf /var/app/notebook.tar.gz

# Set the production port and env
ENV PORT=4001
ENV MIX_ENV=prod

# Run the server
#CMD ./wait-for-it.sh db:5432 && bin/notebook foreground
CMD ["bin/notebook", "foreground"]

EXPOSE 4001
