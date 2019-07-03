# ============================================================
# Build you jekyll blog
# ============================================================
FROM jekyll/jekyll:stable AS build

RUN mkdir /jekyll-minima
WORKDIR /jekyll-minima

# copy the blog source
COPY . .

# permission for bundle to write gemfile.lock
RUN chmod 777 ./

# Install dependencies
RUN bundle install

# Build
RUN bundle exec jekyll build

# ============================================================
# Serve the build files with NGINX
# ============================================================
FROM nginx as nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build files of the blog
COPY --from=build /jekyll-minima/_site /usr/share/nginx/html

EXPOSE 80